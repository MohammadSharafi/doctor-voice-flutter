import 'dart:io';
import 'package:aimedic/app/recordList/model/voice_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/cache_manager.dart';



abstract class IVoiceListService {
  IVoiceListService(this.dio);

  Future<List<VoiceListItem>?> getUserVoices();
  final Dio dio;
}

class VoiceListService extends IVoiceListService with ChangeNotifier, CacheManager{
  VoiceListService(Dio dio) : super(dio);


  @override
  Future<List<VoiceListItem>?> getUserVoices() async {
    try {
     final token=await getToken();

      final response = await dio.get(
        ServicePath.PATH.rawValue,
        options: Options(responseType: ResponseType.json,headers:{'Authorization':'Bearer $token'} ),
      );

      if (response.statusCode == HttpStatus.ok) {
        final texts = List<VoiceListItem>.of(
          response.data.map<VoiceListItem>(
                (json) =>
                VoiceListItem (
                  id:json['id'],
                  text:VoiceText(
                    text:json['text']['text'],
                    id: json['text']['id'],
                  ),
                  status:json['status'],
                  textId:json['textId'],
                  url:json['url'],
                ),
          ),
        );

        return texts;
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
        return '/api/v1/voice/list';
    }
  }
}
