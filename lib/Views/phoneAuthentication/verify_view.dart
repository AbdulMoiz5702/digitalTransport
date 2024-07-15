import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyView extends StatefulWidget {
  final String verificationId;
  const VerifyView({super.key, required this.verificationId});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
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
                var credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: controller.text);

                try {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  setState(() {
                    isLoading = false;
                  });
                } catch (e) {
                  showSnackBar(context, e.toString());
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text("verify"))
        ],
      ),
    );
  }
}
