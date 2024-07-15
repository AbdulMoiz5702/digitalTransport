import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/commonWidgets/round_button.dart';
import 'package:digitalize_transport/Views/driver_auth_handle_view.dart';
import 'package:digitalize_transport/Views/owner_auth_handle_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButtonView extends StatelessWidget {
  const LoginButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/FYP LOGO.png',
              height: 200.h,
            ),
            RoundButton(
                title: "Owner Login",
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const OwnerAuthHandleView()));
                }),
            20.ph,
            RoundButton(
                title: "Driver Login",
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DriverAuthHandleView()));
                }),
          ],
        ),
      ),
    );
  }
}
