import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
      color: AppColors.darkBG
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: [
              Spacer(),
              Container(
                child: Image.asset('assets/images/background.png',color: Colors.white.withOpacity(0.6), colorBlendMode: BlendMode.modulate,),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
