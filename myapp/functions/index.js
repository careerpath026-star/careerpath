const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const crypto = require("crypto");

admin.initializeApp();

const db = admin.firestore();

// Email provider credentials will be stored as Firebase secrets.
// Do NOT put email passwords/API keys in Flutter code.
const EMAIL_API_KEY = defineSecret("EMAIL_API_KEY");

function generateOtp() {
  return crypto.randomInt(100000, 1000000).toString();
}

exports.sendEmailOtp = onCall(
  {
    secrets: [EMAIL_API_KEY],
  },
  async (request) => {
    const data = request.data || {};

    const email = String(data.email || "").trim().toLowerCase();

    if (!email) {
      throw new HttpsError(
        "invalid-argument",
        "Email is required."
      );
    }

    const otp = generateOtp();

    const otpHash = crypto
      .createHash("sha256")
      .update(otp)
      .digest("hex");

    const expiresAt =
      admin.firestore.Timestamp.fromMillis(
        Date.now() + 5 * 60 * 1000
      );

    const otpRef = db
      .collection("email_otps")
      .doc(email);

    await otpRef.set({
      email: email,
      otpHash: otpHash,
      expiresAt: expiresAt,
      attempts: 0,
      verified: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    /*
      IMPORTANT:
      Connect your chosen transactional email provider here.

      Example payload concept:

      await sendEmail({
        to: email,
        subject: "PathSeeker Email Verification",
        text: `Your PathSeeker OTP is ${otp}`,
      });

      EMAIL_API_KEY.value() is available only on the server.
    */

    return {
      success: true,
      message: "OTP generated successfully.",
    };
  }
);

exports.verifyEmailOtp = onCall(async (request) => {
  const data = request.data || {};

  const email = String(data.email || "").trim().toLowerCase();
  const otp = String(data.otp || "").trim();

  if (!email || !otp) {
    throw new HttpsError(
      "invalid-argument",
      "Email and OTP are required."
    );
  }

  if (!/^\d{6}$/.test(otp)) {
    throw new HttpsError(
      "invalid-argument",
      "OTP must contain 6 digits."
    );
  }

  const otpRef = db
    .collection("email_otps")
    .doc(email);

  const otpDoc = await otpRef.get();

  if (!otpDoc.exists) {
    throw new HttpsError(
      "not-found",
      "OTP not found. Please request a new OTP."
    );
  }

  const otpData = otpDoc.data();

  const expiresAt = otpData.expiresAt;
  const attempts = otpData.attempts || 0;

  if (Date.now() > expiresAt.toMillis()) {
    await otpRef.delete();

    throw new HttpsError(
      "deadline-exceeded",
      "OTP has expired."
    );
  }

  if (attempts >= 5) {
    await otpRef.delete();

    throw new HttpsError(
      "resource-exhausted",
      "Too many incorrect attempts."
    );
  }

  const enteredHash = crypto
    .createHash("sha256")
    .update(otp)
    .digest("hex");

  if (enteredHash !== otpData.otpHash) {
    await otpRef.update({
      attempts: admin.firestore.FieldValue.increment(1),
    });

    throw new HttpsError(
      "invalid-argument",
      "Incorrect OTP."
    );
  }

  await otpRef.update({
    verified: true,
    verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return {
    success: true,
    message: "Email verified successfully.",
  };
});