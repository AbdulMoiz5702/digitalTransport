import 'package:digitalize_transport/Controller/Repositories/fcm_repo.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../Controller/Repositories/database_service.dart';

class AssignRouteView extends StatefulWidget {
  const AssignRouteView({super.key});

  @override
  State<AssignRouteView> createState() => _AssignRouteViewState();
}

class _AssignRouteViewState extends State<AssignRouteView> {
  var routes = [
    "Hangu, Samana",
    "KDA, Kohat",
    "Muslim Abad, Hangu",
    "Tall, Hangu",
    "PTC, Hangu",
    "Doaba, Hangu",
  ];
  // var drivers = ["Aslam", "Arbab", "shanawaz", "Bashir", "Bilal"];
  // var vehicleIds = ["123", "345", "7895"];
  var vehicleId;
  var route, driver;
  var startTimeCtrl = TextEditingController();
  var endTimeCtrl = TextEditingController();
  var dateCtrl = TextEditingController();
  var reportingTimeCtrl = TextEditingController();
  var descriptionCntrl = TextEditingController();
  var driversList = <Map<String, dynamic>>[];
  var vehicleList = <Map<String, dynamic>>[];
  var submitLoading = ValueNotifier<bool>(false);
  var isLoading = true;
  Map<String, dynamic>? selectedDriver;
  Map<String, dynamic>? selectedVehicle;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    route = routes[0];
    // driver = drivers[0];
    getDrivers();
  }

  getDrivers() async {
    driversList = await DatabaseService().getRegisteredDrivers();
    vehicleList = await DatabaseService().getRegisteredVehicle();
    if (vehicleList.isNotEmpty) {
      selectedVehicle = vehicleList[0];
    }
    if (driversList.isNotEmpty) {
      selectedDriver = driversList[0];
      driver = selectedDriver!['name'];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route Assiging"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(10.sp),
                shrinkWrap: true,
                children: [
                  CustomText(
                    text: "Driver",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      value: driver,
                      items: driversList
                          .map<DropdownMenuItem>(
                              (e) => DropdownMenuItem<String>(
                                  value: e['name'],
                                  onTap: () {
                                    selectedDriver = e;
                                  },
                                  child: Text(
                                    e['name'],
                                  )))
                          .toList(),
                      // drivers
                      //     .map<DropdownMenuItem>((value) => DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(
                      //           value,
                      //         )))
                      //     .toList(),
                      onChanged: (value) {
                        setState(() {
                          driver = value;
                        });
                      }),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: "Route",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      value: route,
                      items: routes
                          .map<DropdownMenuItem>(
                              (value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  )))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          route = value;
                        });
                      }),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: "Vehicle Id",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      value: vehicleId,
                      items: vehicleList
                          .map<DropdownMenuItem>(
                              (value) => DropdownMenuItem<Map<String, dynamic>>(
                                  value: value,
                                  child: Text(
                                    value['vehicle_id'],
                                  )))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          vehicleId = value;
                        });
                      }),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: "Start Time",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: startTimeCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "fill the filled";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (pickedTime != null) {
                                // DateTime parsedTime = DateFormat.jm()
                                //     .parse(pickedTime.format(context).toString());
                                // var formatedTime =
                                //     DateFormat("HH:mm:ss").format(parsedTime);
                                // print(parsedTime);
                                setState(() {
                                  startTimeCtrl.text =
                                      pickedTime.format(context).toString();
                                });
                              }
                            },
                            icon: const Icon(Icons.av_timer))),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: "End Time",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "fill the filled";
                      }
                      return null;
                    },
                    controller: endTimeCtrl,
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (pickedTime != null) {
                                // DateTime parsedTime = DateFormat.jm()
                                //     .parse(pickedTime.format(context).toString());
                                // var formatedTime =
                                //     DateFormat("HH:mm:ss").format(parsedTime);
                                // print(parsedTime);
                                setState(() {
                                  endTimeCtrl.text =
                                      pickedTime.format(context).toString();
                                });
                              }
                            },
                            icon: const Icon(Icons.av_timer))),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: "Reporting Time",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "fill the filled";
                      }
                      return null;
                    },
                    controller: reportingTimeCtrl,
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (pickedTime != null) {
                                // DateTime parsedTime = DateFormat.jm()
                                //     .parse(pickedTime.format(context).toString());
                                // var formatedTime =
                                //     DateFormat("HH:mm:ss").format(parsedTime);
                                // print(parsedTime);
                                setState(() {
                                  reportingTimeCtrl.text =
                                      pickedTime.format(context).toString();
                                });
                              }
                            },
                            icon: const Icon(Icons.av_timer))),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: "Date",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "fill the filled";
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: dateCtrl,
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2026));
                              if (pickedDate != null) {
                                var formatedDAte =
                                    DateFormat.yMMMd().format(pickedDate);
                                // DateTime parsedTime = DateFormat.jm()
                                //     .parse(pickedTime.format(context).toString());
                                // var formatedTime =
                                //     DateFormat("HH:mm:ss").format(parsedTime);
                                // print(parsedTime);
                                setState(() {
                                  dateCtrl.text = formatedDAte;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_month_outlined))),
                  ),
                  5.ph,
                  CustomText(
                    text: "Description",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "fill the filled";
                      }
                      return null;
                    },
                    controller: descriptionCntrl,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: appColor),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          submitLoading.value = !submitLoading.value;
                          await DatabaseService().storeRoute(
                              assigingDate: dateCtrl.text.trim(),
                              driverName: driver,
                              endTime: endTimeCtrl.text.trim(),
                              reportingDate: reportingTimeCtrl.text.trim(),
                              route: route,
                              startTime: startTimeCtrl.text.trim(),
                              vehicleId: vehicleId,
                              description: descriptionCntrl.text.trim());
                          var result = await FcmRepo()
                              .sendNotification(selectedDriver!['token']);
                          submitLoading.value = !submitLoading.value;
                          showSnackBar(context, "Route Assign Successfully");
                          Navigator.pop(context);
                        } else {
                          showSnackBar(context, 'Please Filled All Fields');
                        }
                      },
                      child: ValueListenableBuilder(
                          valueListenable: submitLoading,
                          builder: (context, value, child) {
                            if (value) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return CustomText(
                                text: "Submit",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              );
                            }
                          }))
                ],
              ),
            ),
    );
  }
}
