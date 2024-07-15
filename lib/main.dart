import 'package:digitalize_transport/Controller/Repositories/database_service.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/Utils/local_notification_service.dart';
import 'Views/driver_auth_handle_view.dart';
import 'Views/login_button_view.dart';
import 'Views/owner_auth_handle_view.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  pref = await SharedPreferences.getInstance();
  if (pref!.getString('identification') != null) {
    identification = pref!.getString("identification");
    runApp(const MyApp());

    // print(identification);
  } else {
    await pref!.setString("identification", 'no identifier');
    identification = pref!.getString("identification");

    runApp(const MyApp());
  }
  // await FirebaseAppCheck.instance.activate();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Digitalize Transport',
            theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.blue,
            ),
            home: child,
          );
        },
        child: identification == 'no identifier'
            ? const LoginButtonView()
            : identification == 'driver'
                ? const DriverAuthHandleView()
                : const OwnerAuthHandleView());
  }
}
