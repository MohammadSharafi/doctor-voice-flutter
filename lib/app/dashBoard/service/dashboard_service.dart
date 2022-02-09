import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/cache_manager.dart';
import '../model/user_dashboard_model.dart';



abstract class IDashBoardService{
  IDashBoardService(this.dio);

  Future<Dashboard?> getDashBoard();
  final Dio dio;
}

class DashBoardService extends IDashBoardService {
  DashBoardService(Dio dio) : super(dio);

  @override
  Future<Dashboard?> getDashBoard() async {
    final token=await CacheManager().getToken();

    final response=await dio.get( DashBoardPath.DashBoard.rawValue, options: Options(responseType: ResponseType.json,headers:{'Authorization':'Bearer $token'}));
    if (response.statusCode == HttpStatus.ok)  {
      return Dashboard.fromJson(response.data);
    }
    else return null;

  }
}



enum DashBoardPath { DashBoard }

extension ServicePathExtension on DashBoardPath {
  String get rawValue {
    switch (this) {
      case DashBoardPath.DashBoard:
        return '/api/v1/metrics/';
    }
  }
}
