import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/utils.dart';
import '../screens/otp_screen.dart';

//for the authentication part of phone validation
class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //after we iinput otp which match the given otp then we signin with email passworf
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        }, 
        verificationFailed: (e) {
          throw Exception(e.message);
        }, 
        //verificationId otp that firebase has created
        codeSent: ((String verificationId,int? resendToken)async{
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        }), codeAutoRetrievalTimeout: (String verificationId) {},);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }
}
