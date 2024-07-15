import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalize_transport/Controller/Repositories/database_service.dart';
import 'package:digitalize_transport/Controller/Utils/local_notification_service.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
import 'package:digitalize_transport/Views/driver_duty_schedule_view.dart';
import 'package:digitalize_transport/Views/map_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverDashBoardView extends StatefulWidget {
  const DriverDashBoardView({super.key});

  @override
  State<DriverDashBoardView> createState() => _DriverDashBoardViewState();
}

class _DriverDashBoardViewState extends State<DriverDashBoardView> {
  Map<String, dynamic>? userData;
  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initializeNotification();
    getUser();
    // openHistorySchedule();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var data = message.data;

      if (data.isNotEmpty) {
        LocalNotificationService.plugin.show(
            message.hashCode,
            message.data['title'],
            message.data['body'],
            LocalNotificationService.notificationDetails);
        await DatabaseService()
            .saveNotification(data['title'], data['body'], message.sentTime);
      }
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  // openHistorySchedule() async {
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }
  // }

  // _handleMessage(RemoteMessage message) {
  //   var notification = message.notification;
  //   if (notification != null) {
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => DriverDutySheduleView(userData: userData)));
  //     }
  //   }
  // }

  getUser() async {
    userData = await DatabaseService().getUserInfo();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      drawer: AppDrawer(
        userData: userData,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: EdgeInsets.all(10.sp),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        break;
                      case 1:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DriverDutySheduleView(
                                      userData: userData!,
                                    )));
                        break;
                      case 2:
                        break;
                      case 3:
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const MapView()));
                        break;
                      case 4:
                        break;
                      case 5:
                        break;
                      case 6:
                        break;
                    }
                  },
                  child: Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                        color: gridColors[index],
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        gridText[index],
                        SizedBox(
                          height: 10.h,
                        ),
                        gridIcon[index]
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    this.userData,
  }) : super(key: key);

  final Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: appColor),
              child: StreamBuilder<DocumentSnapshot>(
                stream: DatabaseService().getDriverData(),
                  builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CupertinoActivityIndicator(color: Colors.black,),);
                    }else if (snapshot.hasError){
                      return Center(child: Text( 'Something went wrong'),);
                    }else if (snapshot.hasData && snapshot.data != null){
                      var data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
                      return ListView(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(data['url']),
                              radius: 30.r,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomText(
                            text: "${data['name']}",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: "Licence: LN-132543",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          )
                        ],
                      );
                    }else{
                      return  Center(child: Text('Check your internet connection'),);
                    }
                  },
              )),
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              backgroundColor: appColor,
              radius: 20.r,
              child: Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
            title: CustomText(
                text: "Profile", fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          ListTile(
            onTap: () async {
              try {
                await FirebaseAuth.instance.currentUser!.delete();
              } on FirebaseAuthException catch (e) {
                if (e.code == "requires-recent-login") {
                  showSnackBar(context, "reauthentication is required");
                }
              } catch (e) {
                showSnackBar(context, e.toString());
              }
            },
            leading: CircleAvatar(
              backgroundColor: appColor,
              radius: 20.r,
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
            title: CustomText(
                text: "Setting", fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              backgroundColor: appColor,
              radius: 20.r,
              child: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
            title: CustomText(
                text: "About us", fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              backgroundColor: appColor,
              radius: 20.r,
              child: Icon(
                Icons.help,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
            title: CustomText(
                text: "Help", fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // Navigator.of(context)
                  //   ..pop()
                  //   ..pop();
                },
                leading: CircleAvatar(
                  backgroundColor: appColor,
                  radius: 20.r,
                  child: Icon(
                    Icons.login_outlined,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
                title: CustomText(
                    text: "Logout",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// builder: (context, snapshot) {
//   return ListView(
//     children: [
//       Align(
//         alignment: Alignment.centerLeft,
//         child: CircleAvatar(
//           backgroundColor: Colors.white,
//           backgroundImage: NetworkImage(userData!['url']),
//           radius: 30.r,
//         ),
//       ),
//       SizedBox(
//         height: 10.h,
//       ),
//       CustomText(
//         text: "${userData!['name']}",
//         fontSize: 18.sp,
//         fontWeight: FontWeight.w400,
//         color: Colors.white,
//       ),
//       CustomText(
//         text: "Licence: LN-132543",
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w300,
//         color: Colors.white,
//       )
//     ],
//   );
// }
