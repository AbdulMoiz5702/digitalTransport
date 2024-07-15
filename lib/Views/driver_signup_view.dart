import 'dart:io';

import 'package:digitalize_transport/Controller/Repositories/auth_repo.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/commonWidgets/round_button.dart';
import 'package:digitalize_transport/Views/commonWidgets/round_text_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverSignUpView extends StatefulWidget {
  const DriverSignUpView({super.key});

  @override
  State<DriverSignUpView> createState() => _DriverSignUpViewState();
}

class _DriverSignUpViewState extends State<DriverSignUpView> {
  final _formKey = GlobalKey<FormState>();
  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var cnicCtrl = TextEditingController();
  var countryCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var confirmPassCtrl = TextEditingController();
  var isVisible1 = ValueNotifier<bool>(false);
  var isVisible2 = ValueNotifier<bool>(false);
  var isLoading = ValueNotifier<bool>(false);
  String? token;
  bool tokenLoading = true;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String imagePath = '';
  String image = '';
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();
  }

  getDeviceToken() async {
    token = await messaging.getToken();
    setState(() {
      tokenLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      backgroundColor: appColor,
      body: tokenLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 110.h,
                      width: 110.w,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          // imagePath.isNotEmpty
                          // ? CircleAvatar(
                          //     backgroundColor: Colors.white,
                          //     backgroundImage: NetworkImage(imagePath),
                          //   )
                          // :
                          image.isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: FileImage(File(image)),
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.white,
                                ),
                          Positioned(
                              bottom: 10.sp,
                              right: 3.sp,
                              child: InkWell(
                                onTap: () async {
                                  // showImage.value = false;
                                  try {
                                    url = await getImage(context);
                                    if (url.isNotEmpty) {
                                      image = url;

                                      setState(() {});
                                    }
                                  } catch (e) {
                                    showSnackBar(context, e.toString());
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3.r),
                                  height: 20.sp,
                                  width: 20.sp,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.r),
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.edit,
                                    color: const Color.fromARGB(
                                        255, 221, 238, 123),
                                    size: 15.sp,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    10.ph,
                    const Text(
                      "Create Account by Driver",
                      style: TextStyle(color: Colors.white),
                    ),
                    30.ph,
                    RoundTextField(
                        inputType: TextInputType.name,
                        prefixIcon: const Icon(Icons.abc),
                        hintText: "Name",
                        controller: nameCtrl),
                    8.ph,
                    RoundTextField(
                        inputType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: "Email",
                        controller: emailCtrl),
                    8.ph,
                    RoundTextField(
                        maxLength: 11,
                        inputType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone),
                        hintText: "Phone",
                        controller: phoneCtrl),
                    8.ph,
                    RoundTextField(
                        maxLength: 13,
                        inputType: TextInputType.number,
                        prefixIcon: const Icon(Icons.join_inner_rounded),
                        hintText: "Cnic",
                        controller: cnicCtrl),
                    8.ph,
                    RoundTextField(
                      inputType: TextInputType.name,
                      hintText: "Country",
                      controller: countryCtrl,
                      prefixIcon: const Icon(Icons.flag),
                    ),
                    8.ph,
                    ValueListenableBuilder(
                      valueListenable: isVisible1,
                      builder: (context, value, child) {
                        return RoundTextField(
                          inputType: TextInputType.visiblePassword,
                          obsecure: value,
                          hintText: "Password",
                          controller: passCtrl,
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                isVisible1.value = !isVisible1.value;
                              },
                              icon: value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                        );
                      },
                    ),
                    8.ph,
                    ValueListenableBuilder(
                      valueListenable: isVisible1,
                      builder: (context, value, child) {
                        return RoundTextField(
                          inputType: TextInputType.visiblePassword,
                          obsecure: value,
                          hintText: "confirm Password",
                          controller: confirmPassCtrl,
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                isVisible2.value = !isVisible2.value;
                              },
                              icon: value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                        );
                      },
                    ),
                    30.ph,
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
                                  title: "Create Account",
                                  color: Colors.cyan,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (passCtrl.text.trim() ==
                                          confirmPassCtrl.text.trim()) {
                                        isLoading.value = !isLoading.value;
                                        await AuthRepo().signUp(
                                            email: emailCtrl.text.trim(),
                                            password: passCtrl.text.trim(),
                                            context: context,
                                            name: nameCtrl.text.trim(),
                                            phone: phoneCtrl.text.trim(),
                                            cnic: cnicCtrl.text.trim(),
                                            token: token,
                                            check: "driver",
                                            url: url);
                                        await pref!.setString(
                                            "identification", 'driver');
                                        identification = 'driver';
                                        isLoading.value = !isLoading.value;
                                      }
                                    }
                                  });
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  // static Future<String> getImage(context) async {
  //File? image;
  // var storage = FirebaseStorage.instance;
  // var fileName = FirebaseAuth.instance.currentUser!.uid;
  // String image = '';
  // try {
  // final pickFile = await ImagePicker()
  //     .pickImage(source: ImageSource.gallery, imageQuality: 80);
  // if (pickFile != null) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (_) {
  //         return Center(
  //             child: Text(
  //           'Please wait...',
  //           style: TextStyle(color: Colors.white, fontSize: 2.sp),
  //         ));
  //       });
  //   image = pickFile.path;
  //   await storage.ref('ProfileImage/$fileName').putFile(File(image));

  //   await storage
  //       .ref('ProfileImage/$fileName')
  //       .getDownloadURL()
  //       .then((value) async {
  // await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .update({'image_url': value});
  // });
  // Navigator.of(context, rootNavigator: true).pop();
  // }
  // } on FirebaseException catch (e) {
  //   showSnackBar(context, e.toString());
  // } catch (e) {
  //   showSnackBar(context, e.toString());
  // }
  // return image;
  // }
}
