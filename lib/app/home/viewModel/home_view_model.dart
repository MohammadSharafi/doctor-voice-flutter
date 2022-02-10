import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/home/home.dart';

import 'package:aimedic/core/network/network_service.dart';


abstract class HomeViewModel extends State<Home> {


 // late final HomeService homeService;
  final Dio dio = NetworkService.instance.dio;


  @override
  void initState() {
    super.initState();
    //homeService = HomeService(dio);
  }
}
