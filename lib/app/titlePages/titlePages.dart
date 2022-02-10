

import 'package:aimedic/core/network/network_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'view/titlePages_view.dart';

class TitlePages extends StatefulWidget{
  static const routeName = '/titlePage';
  final Dio dio = NetworkService.instance.dio;

  @override
  TitlePagesView createState() => new TitlePagesView();
}
