import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
import 'package:digitalize_transport/Views/duty_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverDutySheduleView extends StatelessWidget {
  const DriverDutySheduleView({super.key, required this.userData});
  final Map userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Duty Shedule"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('history')
              .where('driver_name', isEqualTo: userData['name'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data != null) {
              return ListView.builder(
                padding: EdgeInsets.all(10.sp),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DutyDetailsView(
                                      snapshot:
                                          snapshot.data!.docs[index].data(),
                                    )));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomText(
                                  text: snapshot.data!.docs[index]
                                      .data()['assiging_date'],
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text:
                                              "Start Time: ${snapshot.data!.docs[index].data()['start_time']}",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal),
                                      CustomText(
                                          text:
                                              "End Time: ${snapshot.data!.docs[index].data()['end_time']}",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Icon(
                                    Icons.double_arrow_sharp,
                                    size: 40.sp,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Flexible(
                                    child: CustomText(
                                        text:
                                            "${snapshot.data!.docs[index].data()['route']}",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
                },
              );
            } else {
              return const Center(
                child: Text("No History Available"),
              );
            }
          }),
    );
  }
}
