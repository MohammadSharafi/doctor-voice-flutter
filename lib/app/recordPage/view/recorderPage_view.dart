import 'package:aimedic/app/record/record.dart';
import 'package:aimedic/app/recordList/recordlist.dart';
import 'package:aimedic/app/recordPage/viewModel/recordPage_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/constants/app_colors.dart';
import '../../home/globalCubit/global_cubit.dart';
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

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<GlobalCubit>(context).getTitle('Text List',1);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBG,
        body: Container(
          child: Column(
            children: [
            // Inside build method
            SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              minWidth: 120.0,
              minHeight: 36,
              cornerRadius: 10.0,
              activeBgColors: [
                [Color.fromRGBO(57, 57, 57, 1.0)],
                [Color.fromRGBO(57, 57, 57, 1.0)],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.black,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 2,
              borderColor: [Colors.black87],
              labels: ['Record', 'List'],
              radiusStyle: true,
              borderWidth: 2,
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
      ),
    );
  }


}
