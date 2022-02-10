import 'package:flutter/material.dart';
import 'package:aimedic/app/home/home.dart';
import '../recordpage.dart';

abstract class RecorderPageViewModel extends State<RecorderPage> {

  @override
  void initState() {
    super.initState();
  }


  void navigateToHome() {
    Navigator.of(context).pushNamed(Home.routeName);
  }
}
