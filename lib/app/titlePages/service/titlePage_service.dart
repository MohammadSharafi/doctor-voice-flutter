import 'dart:io';
import 'package:aimedic/app/titlePages/model/text_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/cache_manager.dart';



abstract class IHomeService {
  IHomeService(this.dio);

  Future<List<TextListModel>?> getUserTexts();
  final Dio dio;
}

class HomeService extends IHomeService with ChangeNotifier, CacheManager{
  HomeService(Dio dio) : super(dio);


  @override
  Future<List<TextListModel>?> getUserTexts() async {
    try {
     final token=await getToken();

      final response = await dio.get(
        ServicePath.PATH.rawValue,
        options: Options(/*contentType: Headers.jsonContentType,*/responseType: ResponseType.json,headers:{'Authorization':'Bearer $token'} ),
      );

      if (response.statusCode == HttpStatus.ok) {
        final texts = List<TextListModel>.of(
          response.data.map<TextListModel>(
                (json) =>
                TextListModel(
                  text: json['text'],
                  id: json['id'],
                  is_recorded: json['is_recorded'],
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
        return '/api/v1/text/random';
    }
  }
}
