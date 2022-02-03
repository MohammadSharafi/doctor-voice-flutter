import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/profile/service/profile_service.dart';
import 'package:aimedic/core/cache_manager.dart';
import 'package:aimedic/core/network/network_service.dart';


import '../profile.dart';

abstract class ProfileViewModel extends State<Profile>
    with CacheManager, ChangeNotifier {
      
   late final ProfileService profileService;
  final Dio dio = NetworkService.instance.dio;

  //ProfileService get manager => context.read<ProfileService>();

  @override
  void initState() {
    super.initState();
    profileService = ProfileService(dio);
  //  manager.fetchUserDevicesList();
  }

}
