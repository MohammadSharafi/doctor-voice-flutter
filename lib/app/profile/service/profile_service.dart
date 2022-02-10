import 'dart:io';
import 'package:aimedic/app/profile/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/cache_manager.dart';


abstract class IProfileService {
  IProfileService(this.dio);

  final Dio dio;
}

class ProfileService extends IProfileService with ChangeNotifier, CacheManager{
  ProfileService(Dio dio) : super(dio);



  Future<ProfileModel?> getProfile() async {
    try {
      final token=await getToken();

      final response = await dio.get(
        ServicePath.PATH.rawValue,
        options: Options(headers:{'Authorization':'Bearer $token'} ),
      );

      if (response.statusCode == HttpStatus.ok) {
        final profile = ProfileModel.fromJson(response.data);

        return profile;
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
        return '/api/v1/users/me';
    }
  }
}
