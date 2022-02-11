import 'package:flutter/material.dart';
import '../titlePages/model/ScreenArguments.dart';
import 'view/recorderPage_view.dart';

class RecorderPage extends StatefulWidget {
  static const routeName = '/RecorderPageScreen';
  final ScreenArguments args;

  const RecorderPage({Key? key, required this.args}) : super(key: key);

  @override
  RecorderPageView createState() => new RecorderPageView(args);
}
