import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  // final Color shadowColor;
  final VoidCallback onPressed;
  String? image;
  RoundButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.textColor,
      // required this.shadowColor,
      this.image,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.h,
        width: 366.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: color,
          // boxShadow: [
          //   BoxShadow(
          //     color: shadowColor,
          //     blurRadius: 24.sp,
          //     offset: Offset(4.sp, 8.sp),
          //   )
          // ]
        ),
        child: Center(
            child: image != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 70.w, right: 25.w),
                        child: Image.asset(
                          image!,
                          height: 22.h,
                          width: 22.w,
                        ),
                      ),
                      CustomText(
                        text: title,
                        color: textColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                : CustomText(
                    text: title,
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  )),
      ),
    );
  }
}
