import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalize_transport/Controller/Repositories/database_service.dart';
import 'package:digitalize_transport/Core/app_colors.dart';
import 'package:digitalize_transport/Views/assign_route_view.dart';
import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
import 'package:digitalize_transport/Views/owner_history_view.dart';
import 'package:digitalize_transport/Views/register_vehicle_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerDashBoardView extends StatefulWidget {
  const OwnerDashBoardView({super.key});

  @override
  State<OwnerDashBoardView> createState() => _OwnerDashBoardViewState();
}

class _OwnerDashBoardViewState extends State<OwnerDashBoardView> {
  var gridColors = [
    Colors.green,
    Colors.pink,
    Colors.blue,
    appColor,
    Colors.yellow,
    Colors.pinkAccent,
    Colors.brown
  ];

  var gridText = [
    CustomText(
      text: "Notification",
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    CustomText(
      text: "Route Assign",
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    CustomText(
      textAlign: TextAlign.center,
      text: "Vehicle Registeration",
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    CustomText(
      text: "History",
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
    CustomText(
      text: "Track Vehicle",
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
      Icons.app_registration_rounded,
      color: Colors.white,
      size: 40.sp,
    ),
    Icon(
      Icons.history,
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
    ),
    Icon(
      Icons.track_changes,
      color: Colors.white,
      size: 40.sp,
    )
  ];

  Map<String, dynamic>? userData;

  var isLoading = true;

  getUser() async {
    userData = await DatabaseService().getUserInfo();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      drawer: AppDrawer(
        data: userData,
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
                                builder: (_) => const AssignRouteView()));
                        break;
                      case 2:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RegisterVehicleView()));
                        break;
                      case 3:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const OwnerHistoryView()));
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
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: appColor),
              child: StreamBuilder<DocumentSnapshot>(
                stream: DatabaseService().getOwnerData(),
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
            onTap: () {},
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
                Icons.settings_outlined,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
            title: CustomText(
                text: "App Setting",
                fontSize: 18.sp,
                fontWeight: FontWeight.w500),
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
