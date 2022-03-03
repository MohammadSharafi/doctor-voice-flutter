import 'package:aimedic/app/record/view/record_view.dart';
import 'package:flutter/material.dart';
import '../titlePages/model/ScreenArguments.dart';

class Record extends StatefulWidget {
  final ScreenArguments args;

  const Record({Key? key, required this.args}) : super(key: key);


  @override
  RecordView createState() => new RecordView(args);
}
