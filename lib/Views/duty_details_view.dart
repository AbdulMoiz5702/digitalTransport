import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DutyDetailsView extends StatelessWidget {
  DutyDetailsView({super.key, required this.snapshot});

  Map<String, dynamic> snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Duty Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.sp),
              color: appColor,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Vehicle Id:",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                        CustomText(
                          text: "Driver Name:",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: snapshot['vehicle_id']['vehicle_id'],
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                        CustomText(
                          text: snapshot['driver_name'],
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.sp),
                  color: appColor,
                  child: Column(
                    children: [
                      CustomText(
                        text: "Route",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: snapshot['route'],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding: EdgeInsets.all(8.sp),
                  color: appColor,
                  child: Column(
                    children: [
                      CustomText(
                        text: "Reporting Time",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: snapshot['reporting_date'],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    color: appColor,
                    child: Column(
                      children: [
                        CustomText(
                          text: "Start Time",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                        CustomText(
                          text: snapshot['start_time'],
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    color: appColor,
                    child: Column(
                      children: [
                        CustomText(
                          text: "End Time",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                        CustomText(
                          text: snapshot['end_time'],
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.all(10.sp),
              color: appColor,
              child: Center(
                child: Column(
                  children: [
                    CustomText(
                        text: "Date",
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal),
                    CustomText(
                        text: snapshot['assiging_date'],
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              color: appColor,
              padding: EdgeInsets.all(10.sp),
              child: Column(children: [
                CustomText(
                    text: "Description",
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
                CustomText(
                    color: Colors.white,
                    text: snapshot['description'],
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal)
              ]),
            )
          ],
        ),
      ),
    );
  }
}
