import 'dart:io';

import 'package:digitalize_transport/Controller/Repositories/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRepo {
  DatabaseService databaseService = DatabaseService();
  final auth = FirebaseAuth.instance;
  signIn(email, password, BuildContext context, check) async {
    try {
       await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print(credential);
      // Navigator.pop(context);
      // info = await DatabaseService().getUserInfo(check);
      // if (check == 'owner') {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (_) => OwnerDashBoardView()));
      // } else {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (_) => DriverDashBoardView()));
      // }
      Fluttertoast.showToast(
          msg: "Sussccesfully login", backgroundColor: Colors.cyan);
    } on SocketException {
      showSnackBar(context, "No internet connection");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "User Not Found");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "wrong password");
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, "invalid email");
      } else {
        showSnackBar(context, e.toString());
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  signUp(
      {required email,
      required password,
      required context,
      required name,
      required phone,
      required cnic,
      required token,
      required check,
      required url}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value)  {
        if (check == 'owner') {
           databaseService.insertOwnerData(
              email, password, name, phone, cnic, token, url, context);
        } else {
           databaseService.insertDriverData(
              email, password, name, phone, cnic, token, url, context);
        }
      });
      //signout the user when signup
      //  throw SigninSignupException('successfully signup');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "password weak");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "account already in use");
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, "invalid email");
      } else {
        showSnackBar(context, e.toString());
      }
    } on SocketException {
      showSnackBar(context, "No Internet Exception");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  phoneAuth(phone, context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: "+92 $phone",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await FirebaseAuth.instance.signInWithCredential(credential);
        // _showSnackBar(context, "successfully login");
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          showSnackBar(context, "invalid phone number");
        } else if (e.code == 'invalid-verification-id') {
          showSnackBar(context, "invalid verification id");
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        var code = await buildPinPut(context);
        var credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: code);
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("time out");
      },
    );
  }
}
