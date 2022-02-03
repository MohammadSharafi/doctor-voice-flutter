import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:aimedic/app/profile/service/profile_service.dart';
import 'package:aimedic/app/profile/viewModel/profile_view_model.dart';
import 'package:aimedic/core/widgets/rounded_button.dart';
import 'package:aimedic/core/widgets/rounded_input.dart';

class ProfileView extends ProfileViewModel {
  @override
  void initState() {
    super.initState();
  //  homeViewModel.fetchUserDevicesList();
  }
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerCode = TextEditingController();

 // ProfileService get homeViewModel => context.read<ProfileService>();

  @override
  Widget build(BuildContext context) {
   // final homeViewModel = Provider.of<ProfileService>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 56,
          ),
          Container(
            width: double.maxFinite,
            child: Container(
              height: 140,
              width: 140,
              alignment: Alignment.center,
              padding: EdgeInsets.all(45),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                    width: 1,
                  ),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                'assets/images/Iconly-Bold-Add User.svg',
                width: 50,
                height: 50,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: double.maxFinite,
            child: Center(
              child: Text(
                'Profile image',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 50,),
          Text(
            'Full name',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6,),
          RoundedInputField(
            onChanged: (String value) {
              if (value.length == 11 && value.substring(0, 2).contains('09')) {}
            },
            controller: controllerName,
          ),
          SizedBox(height: 20,),

          Text(
            'Medical system code',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6,),

          RoundedInputField(
            onChanged: (String value) {
              if (value.length == 11 && value.substring(0, 2).contains('09')) {}
            },
            controller: controllerCode,
          ),
          SizedBox(height: 16,),

          RoundedButton(
            text: "Submit",
            press: () {
            },
          ),
        ],
      ),
    );
  }
}
