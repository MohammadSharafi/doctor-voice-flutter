import 'dart:io';
import 'package:aimedic/app/record/models/fileUploadModel.dart';
import 'package:aimedic/app/record/models/fileUploadModelResponse.dart';
import 'package:aimedic/app/record/models/filecreateModel.dart';
import 'package:aimedic/app/record/models/filecreateModelResponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/cache_manager.dart';


abstract class IRecordService {
  IRecordService(this.dio);

 // Future<UserDevicesList?> getUserDevicesList(UserDevicesListRequest model);
  final Dio dio;
}

class RecordService extends IRecordService with ChangeNotifier, CacheManager{
  RecordService(Dio dio) : super(dio);


  @override
  Future<FileUploadModelRes?> sendFile(File file) async {

    final token=await CacheManager().getToken();
    var formData = FormData.fromMap({
      'file':await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),

    });
    final response=await dio.post(ServicePath.PATH.rawValue,
        data: formData,
        options: Options(headers: {
          'Authorization':'Bearer $token',/*'Content-Type' : 'multipart/form-data'*/
        } // set content-length
        ));
    if (response.statusCode == HttpStatus.ok) {
      final serv = FileUploadModelRes.fromJson(response.data);
      return serv;

    }
    else{
      return null;
    }

  }

  Future<createVoiceModelResponse?> creatFile(createVoiceModel model)  async {
    final token=await CacheManager().getToken();
    final response=await dio.post(ServicePath.CREAT.rawValue, data: model,
        options: Options(
            headers: {'Authorization':'Bearer $token',}
            ,contentType: Headers.jsonContentType));
    if (response.statusCode == HttpStatus.ok)  {
      return createVoiceModelResponse.fromJson(response.data);
    }
    else return null;

  }


}

enum ServicePath { PATH ,CREAT}

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.PATH:
        return '/api/v1/file/upload/voice';
      case ServicePath.CREAT:
        return '/api/v1/voice';
    }
  }
}
