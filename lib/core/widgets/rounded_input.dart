import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String? data)? validator;
   RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
     required this.controller,
     this.validator,
     required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 0,
          right: 0,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.primaryLightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        Container(
          height: 45,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryGray,
            borderRadius: BorderRadius.circular(12),

          ),
          child: Center(
            child: TextFormField(
              keyboardType:TextInputType.phone ,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              controller: controller,
              onChanged: (value)=>onChanged(value),
              cursorColor: AppColors.primaryLightBlue,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            ),
          ),
        ),
      ],
    );
  }
}
