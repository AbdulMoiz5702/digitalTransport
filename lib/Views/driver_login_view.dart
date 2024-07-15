import 'package:digitalize_transport/Controller/Repositories/auth_repo.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
import 'package:digitalize_transport/Views/commonWidgets/round_button.dart';
import 'package:digitalize_transport/Views/commonWidgets/round_text_field.dart';
import 'package:digitalize_transport/Views/driver_signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

class DriverLoginView extends StatefulWidget {
  const DriverLoginView({super.key});

  @override
  State<DriverLoginView> createState() => _DriverLoginViewState();
}

class _DriverLoginViewState extends State<DriverLoginView> {
  final _formKey = GlobalKey<FormState>();
  var emailCntrl = TextEditingController();
  var passCntrl = TextEditingController();
  var isVisible = ValueNotifier<bool>(false);
  var isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: identification == 'driver'
            ? null
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
      ),
      backgroundColor: appColor,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10.sp),
          children: [
            SizedBox(
              height: 50.h,
            ),
            Image.asset(
              'assets/images/FYP LOGO.png',
              height: 150.h,
            ),
            Center(
              child: CustomText(
                  color: Colors.white,
                  text: "Digitalize Transport",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: CustomText(
                  color: Colors.white,
                  text: "Driver Login",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 30.h,
            ),
            RoundTextField(
              inputType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
              hintText: 'Email',
              controller: emailCntrl,
            ),
            SizedBox(
              height: 10.h,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isVisible,
              builder: (context, value, child) {
                return RoundTextField(
                    inputType: TextInputType.visiblePassword,
                    obsecure: value,
                    hintText: 'Password',
                    controller: passCntrl,
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () {
                          isVisible.value = !isVisible.value;
                        },
                        icon: value
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)));
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              height: 50.h,
              width: 366.w,
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(30.r)),
              child: ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, value, child) {
                    if (value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return RoundButton(
                          title: "Login",
                          color: Colors.cyan,
                          textColor: Colors.white,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              isLoading.value = !isLoading.value;
                              await AuthRepo().signIn(
                                  emailCntrl.text.trim(),
                                  passCntrl.text.trim(),
                                  scaffoldKey2.currentContext!,
                                  'driver');
                              await pref!.setString("identification", 'driver');
                              identification = 'driver';

                              isLoading.value = !isLoading.value;
                              emailCntrl.clear();
                              passCntrl.clear();
                            }
                          });
                    }
                  }),
            ),
            10.ph,
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (_) => const PhoneAuthenticationView()));
            //   },
            //   child: const Text("Login with phone number"),
            // ),
            // SizedBox(
            //   height: 30.h,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DriverSignUpView()));
                    },
                    child: const Text(
                      'SignUp',
                      style: TextStyle(color: Colors.cyan),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
