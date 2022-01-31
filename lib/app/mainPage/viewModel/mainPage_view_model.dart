import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/mainPage/service/mainPage_service.dart';
import 'package:aimedic/core/cache_manager.dart';
import 'package:aimedic/core/network/network_service.dart';
import 'package:provider/provider.dart';

import '../mainPage.dart';

abstract class MainPageViewModel extends State<MainPage>
    with CacheManager, ChangeNotifier {
      
   late final MainPageService mainPageService;
  final Dio dio = NetworkService.instance.dio;

  MainPageService get manager => context.read<MainPageService>();

  @override
  void initState() {
    super.initState();
    mainPageService = MainPageService(dio);
    manager.fetchUserDevicesList();
  }

}
