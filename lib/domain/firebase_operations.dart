// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';

// Future<String> phoneVerification() async {
//   log("sms sent");
//   String? isSmsSent;
//   await FirebaseAuth.instance.verifyPhoneNumber(
//     timeout: Duration(seconds: 5),
//     phoneNumber: "+917994298210",
//     verificationCompleted: (phoneAuthCredential) async {
//       await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
//       log("code sent1");
//     },
//     verificationFailed: (error) async {
//       log("code sent2");
//       isSmsSent = "failed";
//     },
//     codeSent: (verificationId, forceResendingToken) async {
//       log("code sent 3");
//       isSmsSent = await verificationId;
//       log("code sent $isSmsSent");
//       return;
//     },
//     codeAutoRetrievalTimeout: (verificationId) {
//       log("code sent4 $verificationId");

//       isSmsSent = verificationId;
//     },
//   );
//   print("the return statement $isSmsSent");
//   return isSmsSent == null ? "" : isSmsSent!;
// }
