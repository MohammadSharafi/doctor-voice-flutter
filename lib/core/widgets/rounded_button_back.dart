import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedButtonBack extends StatelessWidget {
  final Function()? press;
  const RoundedButtonBack({
    Key? key,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      height: 50,
      child: newElevatedButton(),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.darkBG,
          borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: AppColors.primaryLightBlue,)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 12,
              child: SvgPicture.asset(
                'assets/images/Iconly-Bold-Arrow - Left.svg',
                height: 8,
                width: 8,
                color:AppColors.primaryLightBlue,
              ),
            ),
            Center(
              child: Text(
                'Back to Home',
                style: TextStyle(color: AppColors.primaryLightBlue,fontSize: 13,fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        ),
    );
  }
}
