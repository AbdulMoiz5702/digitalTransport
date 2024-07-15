import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Views/commonWidgets/custom_text.dart';

buildPinPut(context) {
  String optCode = '';
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
            // content: Pinput(
            //   onCompleted: (code) {
            //     optCode = code;
            //   },
            // ),
            );
      });
  return optCode;
}

showSnackBar(BuildContext context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message.toString()),
    backgroundColor: Colors.cyan,
  ));
}

extension spacing on num {
  SizedBox get ph => SizedBox(
        height: toDouble().h,
      );
  SizedBox get pw => SizedBox(
        width: toDouble().w,
      );
}

dynamic info;
final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

var gridColors = [
  Colors.green,
  Colors.pink,
  Colors.blue,
  appColor,
  Colors.yellow,
  Colors.pinkAccent
];

var gridText = [
  CustomText(
    text: "Notification",
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  CustomText(
    text: "Duty Shedule",
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  CustomText(
    text: "Chat Box",
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  CustomText(
    text: "Your Location",
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  CustomText(
    text: "Announcement",
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  CustomText(
    text: "Attendence",
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
];

var gridIcon = [
  Icon(
    Icons.circle_notifications_outlined,
    color: Colors.white,
    size: 40.sp,
  ),
  Icon(
    Icons.location_on_outlined,
    color: Colors.white,
    size: 40.sp,
  ),
  Icon(
    Icons.chat,
    color: Colors.white,
    size: 40.sp,
  ),
  Icon(
    Icons.share_location_sharp,
    color: Colors.white,
    size: 40.sp,
  ),
  Icon(
    Icons.speaker_group,
    color: Colors.white,
    size: 40.sp,
  ),
  Icon(
    Icons.co_present,
    color: Colors.white,
    size: 40.sp,
  )
];

SharedPreferences? pref;
String? identification;

Future<String> getImage(BuildContext context) async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image!.path;
}
