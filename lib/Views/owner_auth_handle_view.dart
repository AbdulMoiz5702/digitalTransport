import 'package:digitalize_transport/Views/owner_signin_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'owner_dashboard_view.dart';

class OwnerAuthHandleView extends StatelessWidget {
  const OwnerAuthHandleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return OwnerDashBoardView();
            } else {
              return const OwnerSignInView();
            }
          }),
    );
  }
}
