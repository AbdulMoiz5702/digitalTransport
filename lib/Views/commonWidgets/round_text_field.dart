import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final bool? obsecure;
  final Widget? suffixIcon;
  final TextInputType inputType;
  final int? maxLength;
  const RoundTextField({
    Key? key,
    this.suffixIcon,
    this.obsecure = false,
    this.prefixIcon,
    required this.hintText,
    required this.controller,
    this.onFieldSubmitted,
    required this.inputType,
    this.maxLength,
  }) : super(key: key);

  @override
  State<RoundTextField> createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      obscuringCharacter: "*",
      obscureText: widget.obsecure!,
      controller: widget.controller,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
          counterText: "",
          errorStyle: const TextStyle(color: Colors.white),
          // isDense: true,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w)),
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please filled the field';
        } else {
          return null;
        }
      },
    );
  }
}
