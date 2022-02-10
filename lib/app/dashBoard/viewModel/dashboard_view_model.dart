import 'package:flutter/material.dart';
import 'package:aimedic/core/cache_manager.dart';


import '../../../core/network/network_service.dart';
import '../dashboard.dart';

abstract class DashBoardViewModel extends State<DashBoard>
    with CacheManager, ChangeNotifier {
      
  // late final DashBoardService mainPageService;
  final dio = NetworkService.instance.dio;

 // DashBoardService get manager => context.read<DashBoardService>();

  @override
  void initState() {
    super.initState();
    //mainPageService = DashBoardService(dio);
    //manager.fetchUserDevicesList();
  }

}
