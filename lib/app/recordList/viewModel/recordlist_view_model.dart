import 'package:aimedic/app/record/service/record_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/core/network/network_service.dart';


import '../recordlist.dart';


abstract class RecordListViewModel extends State<RecordList>{

  late final RecordService recordService;
  final Dio dio = NetworkService.instance.dio;

  //RecordService get manager => context.read<RecordService>();

  @override
  void initState() {
    super.initState();
    recordService = RecordService(dio);
   // manager.fetchUserDevicesList();
  }

}
