import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:aimedic/app/dashBoard/service/dashboard_service.dart';
import 'package:aimedic/app/dashBoard/viewModel/dashboard_view_model.dart';
import 'package:aimedic/core/utils/colors.dart';

class DashBoardView extends DashBoardViewModel {
  @override
  void initState() {
    super.initState();
    homeViewModel.fetchUserDevicesList();
  }

  DashBoardService get homeViewModel => context.read<DashBoardService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          //Recording details
          Container(
            height: MediaQuery.of(context).size.height * ((3.4) / 8),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Color.fromARGB(255, 21, 34, 45),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Recording details',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 21, 34, 45),
                ),
                //text
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Text(
                              'Text',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Submitted texts',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryLightBlue, width: 1)),
                          child: Text(
                            '37',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryLightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Time
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Text(
                              'Time(min)',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Time recorded',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryLightBlue, width: 1)),
                          child: Text(
                            '187',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryLightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Score
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Text(
                              'Score(%)',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Current rating',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryLightBlue, width: 1)),
                          child: Text(
                            '90',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryLightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * (1 / 24),
          ),

          //Recording status
          Container(
            height: MediaQuery.of(context).size.height * (1 / 4),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Color.fromARGB(255, 21, 34, 45),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Recording status',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 21, 34, 45),
                ),
                SizedBox(height: 16,),

                Row(
                  children: [
                    SizedBox(width: 16,),
                    //confirmed
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.height * (1 / 8.5),
                          decoration: BoxDecoration(
                            color: AppColors.greenStatusBg,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: AppColors.greenStatus,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Confirmed',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.greenStatus,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '16 Text',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.greenStatus,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                            ],),
                        )),
                    SizedBox(width: 16,),
                    //pending
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.height * (1 / 8.5),
                          decoration: BoxDecoration(
                            color: AppColors.blueStatusBg,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: AppColors.blueStatus,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pending',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.blueStatus,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '16 Text',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.blueStatus,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                            ],),
                        )),
                    SizedBox(width: 16,),
                    //failed
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.height * (1 / 8.5),
                          decoration: BoxDecoration(
                            color: AppColors.redStatusBg,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: AppColors.redStatus,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Failed',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.redStatus,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '16 Text',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.redStatus,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                            ],),
                        )),
                    SizedBox(width: 16,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
