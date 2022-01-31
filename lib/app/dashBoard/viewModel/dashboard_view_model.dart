import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/dashBoard/service/dashboard_service.dart';
import 'package:aimedic/core/cache_manager.dart';
import 'package:aimedic/core/network/network_service.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

abstract class DashBoardViewModel extends State<DashBoard>
    with CacheManager, ChangeNotifier {
      
   late final DashBoardService mainPageService;
  final Dio dio = NetworkService.instance.dio;

  DashBoardService get manager => context.read<DashBoardService>();

  @override
  void initState() {
    super.initState();
    mainPageService = DashBoardService(dio);
    manager.fetchUserDevicesList();
  }

}
