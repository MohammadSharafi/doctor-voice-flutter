import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/cache_manager.dart';

import 'RefreshTokenModel.dart';


abstract class IRefreshService {
  IRefreshService(this.dio);

  final Dio dio;
}

class RefreshService extends IRefreshService with ChangeNotifier, CacheManager{
  RefreshService(Dio dio) : super(dio);

  Future refreshToken() async {
    try {
      final token=await getRefreshToken();

      final response = await dio.post(
        ServicePath.PATH.rawValue,
        options: Options(headers:{'Authorization':'Bearer $token'} ),
      );

      if (response.statusCode == HttpStatus.ok) {
        final refresh = RefreshTokenModel.fromJson(response.data);
        saveToken(refresh.accessToken ?? '');
        saveRefreshToken(refresh.refreshToken ?? '');

        return refresh;
      }

      return null;
    }
    catch (e) {
      print(e);
      throw e;
    }
  }

}

enum ServicePath { PATH }

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.PATH:
        return '/api/v1/auth/refresh-token';
    }
  }
}
