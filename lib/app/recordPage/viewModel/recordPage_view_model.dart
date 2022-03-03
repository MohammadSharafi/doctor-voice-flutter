import 'package:flutter/material.dart';
import 'package:aimedic/app/home/home.dart';
import '../recordpage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class RecorderPageViewModel extends State<RecorderPage> {

  @override
  void initState() {
    super.initState();
  }


  void navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(Home.routeName,(Route<dynamic> route) => false);
  }
}
