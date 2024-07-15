import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:digitalize_transport/Views/phoneAuthentication/verify_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthenticationView extends StatefulWidget {
  const PhoneAuthenticationView({super.key});

  @override
  State<PhoneAuthenticationView> createState() =>
      _PhoneAuthenticationViewState();
}

class _PhoneAuthenticationViewState extends State<PhoneAuthenticationView> {
  var controller = TextEditingController();
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Authentication"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          20.ph,
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: "+92 ${controller.text.trim()}",
                    verificationCompleted: (context) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    verificationFailed: (e) {
                      showSnackBar(context, e.toString());
                      setState(() {
                        isLoading = false;
                      });
                    },
                    codeSent: (String verification, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VerifyView(
                                    verificationId: verification,
                                  )));
                      setState(() {
                        isLoading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      showSnackBar(context, e.toString());
                      setState(() {
                        isLoading = false;
                      });
                    });
              },
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text("login"))
        ],
      ),
    );
  }
}
