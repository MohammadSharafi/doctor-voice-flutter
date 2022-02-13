import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading {
  static final loading = Container(
    margin: EdgeInsets.all(130),
    child: Lottie.asset('assets/lotti/lf30_1lbqqdlb.json'),
  );
}
