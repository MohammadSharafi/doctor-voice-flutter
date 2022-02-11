import 'package:aimedic/app/record/record.dart';
import 'package:aimedic/app/recordList/recordlist.dart';
import 'package:aimedic/app/recordPage/viewModel/recordPage_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../titlePages/model/ScreenArguments.dart';

class RecorderPageView extends RecorderPageViewModel {

  PageController controller = PageController();
  final ScreenArguments args;

  RecorderPageView(this.args);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          children: [
          // Inside build method
          SizedBox(
            height: 10,
          ),
          ToggleSwitch(
            minWidth: 120.0,
            cornerRadius: 8.0,
            activeBgColors: [
              [Colors.grey.shade400],
              [Colors.grey.shade400]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.black,
            inactiveFgColor: Colors.white,
            initialLabelIndex: 0,
            totalSwitches: 2,
            labels: ['Record', 'List'],
            radiusStyle: true,
            onToggle: (index) {
              print('switched to: $index');
              controller.jumpToPage(index!);
            },
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: <Widget>[
                Record(args: args,),
                RecordList(),
              ],
            ),
          ),
        ],),
      ),
    );
  }


}
