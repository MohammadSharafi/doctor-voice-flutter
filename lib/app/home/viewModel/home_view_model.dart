import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/home/home.dart';
import 'package:aimedic/app/home/service/home_service.dart';
import 'package:aimedic/core/cache_manager.dart';
import 'package:aimedic/core/network/network_service.dart';
import 'package:provider/provider.dart';

abstract class HomeViewModel extends State<Home>
    with CacheManager, ChangeNotifier {
      
   late final HomeService homeService;
  final Dio dio = NetworkService.instance.dio;

  HomeService get manager => context.read<HomeService>();

  @override
  void initState() {
    super.initState();
    homeService = HomeService(dio);
    manager.fetchUserDevicesList();
  }

}
