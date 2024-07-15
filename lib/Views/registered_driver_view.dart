// import 'package:digitalize_transport/Core/app_colors.dart';
// import 'package:digitalize_transport/Views/assign_route_view.dart';
// import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RegisteredDriverView extends StatelessWidget {
//   const RegisteredDriverView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Drivers"),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(10.sp),
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (_) => const AssignRouteView()));
//             },
//             child: Card(
//               color: appColor,
//               child: Padding(
//                 padding: EdgeInsets.all(8.sp),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         const Text(
//                           "Driver Name:",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         SizedBox(
//                           width: 60.w,
//                         ),
//                         CustomText(
//                             text: "Shahid",
//                             color: Colors.white,
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w400)
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Text("Driver Id:",
//                             style: TextStyle(color: Colors.white)),
//                         SizedBox(
//                           width: 60.w,
//                         ),
//                         CustomText(
//                             text: "526828dtsgr",
//                             color: Colors.white,
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w400)
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
