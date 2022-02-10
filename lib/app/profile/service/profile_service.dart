import 'dart:io';
import 'package:aimedic/app/profile/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/cache_manager.dart';

import '../../record/models/fileUploadModelResponse.dart';
import '../model/profile_update_response.dart';

abstract class IProfileService {
  IProfileService(this.dio);

  final Dio dio;
}

class ProfileService extends IProfileService with ChangeNotifier, CacheManager {
  ProfileService(Dio dio) : super(dio);

  Future<ProfileModel?> getProfile() async {
    try {
      final token = await getToken();

      final response = await dio.get(
        ServicePath.PATH.rawValue,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final profile = ProfileModel.fromJson(response.data);

        return profile;
      }

      return null;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<ProfileModel?> setProfile(ProfileUploadResponse request) async {
    try {
      final token = await getToken();

      final response = await dio.post(ServicePath.PATH.rawValue,
          data: request,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }, contentType: Headers.jsonContentType));

      if (response.statusCode == HttpStatus.ok) {
        final profile = ProfileModel.fromJson(response.data);

        return profile;
      }

      return null;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<FileUploadModelRes?> setIMAGE(File file) async {
    final token = await CacheManager().getToken();
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    });
    final response = await dio.post(ServicePath.PATH.rawValue,
        data: formData,
        options: Options(headers: {
          'Authorization':
              'Bearer $token', /*'Content-Type' : 'multipart/form-data'*/
        } // set content-length
            ));
    if (response.statusCode == HttpStatus.ok) {
      final serv = FileUploadModelRes.fromJson(response.data);
      return serv;
    } else {
      return null;
    }
  }
}

enum ServicePath { PATH, UPLOAD }

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.PATH:
        return '/api/v1/users/me';
      case ServicePath.UPLOAD:
        return '/api/v1/file/upload/profile';
    }
  }
}
