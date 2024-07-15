import 'package:digitalize_transport/Controller/Repositories/database_service.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:digitalize_transport/Views/commonWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Core/app_colors.dart';

class RegisterVehicleView extends StatefulWidget {
  const RegisterVehicleView({super.key});

  @override
  State<RegisterVehicleView> createState() => _RegisterVehicleViewState();
}

class _RegisterVehicleViewState extends State<RegisterVehicleView> {
  var controller = TextEditingController();
  var submitLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Registeration"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Enter Vehicle Number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
            20.ph,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (controller.text.isNotEmpty) {
                      submitLoading.value = !submitLoading.value;
                      await DatabaseService()
                          .registerVehicle(controller.text.trim());
                      submitLoading.value = !submitLoading.value;
                      showSnackBar(context, "vehicle registered");
                      Navigator.pop(context);
                    } else {
                      showSnackBar(context, "enter vehicle number");
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: appColor),
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
                            text: 'Register',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          );
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }
}
