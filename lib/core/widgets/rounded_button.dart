import 'package:flutter/material.dart';
import 'package:aimedic/core/widgets/constants.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function()? press;
  final Color? color, textColor;
  const RoundedButton({
    Key? key,
    this.text,
    @required this.press,
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
      height: 50,
      child: ElevatedButton(
        child: Text(
          text!,
          style: TextStyle(color: textColor),
        ),
        onPressed: press,
        style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 4),
            textStyle: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w300)),
      ),
    );
  }
}
