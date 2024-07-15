import 'package:digitalize_transport/Views/driver_dashboard_view.dart';
import 'package:digitalize_transport/Views/driver_login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'driver_signup_view.dart';

class DriverAuthHandleView extends StatelessWidget {
  const DriverAuthHandleView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return DriverDashBoardView();
          } else {
            return const DriverLoginView();
          }
        });
  }
}
