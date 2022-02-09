import 'package:flutter/material.dart';
import 'package:aimedic/core/widgets/constants.dart';

class RoundedButtonLoading extends StatelessWidget {
  final Color? color, textColor;
  const RoundedButtonLoading({
    Key? key,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return Container(
      height:60 ,
      child: ElevatedButton(
        child: Container(
            height:40 ,
            width:40 ,
            child: CircularProgressIndicator()),
        onPressed: (){},
        style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w300)),
      ),
    );
  }
}
