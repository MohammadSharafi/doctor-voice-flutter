import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:aimedic/app/home/home.dart';
import 'package:aimedic/app/login/login.dart';
import 'package:aimedic/app/otp/viewModel/otp_view_model.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:aimedic/core/widgets/rounded_button.dart';

import '../../../core/widgets/rounded_button_loading.dart';
import '../cubit/otp_cubit.dart';

class OTPView extends OTPViewModel {
  final EdgeInsets paddingLow = EdgeInsets.all(8.0);
  late CountdownTimerController controllerCountdownTimer;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 180;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
   bool timeFinish=false;
  // ignore: close_sinks
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerCountdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<OTPCubit, OTPState>(
      builder: (context, state) {
        if (state is LoadedState) {
          fetchUserOTP(state.response);
        }
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Background(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 65,
                      ),

                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            padding: EdgeInsets.only(
                                left: 0, top: 10, right: 40, bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                navigateToLogin();
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/Iconly-Bold-Arrow - Left.svg',
                                    height: 8,
                                    width: 8,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter the verification code",
                          style: GoogleFonts.yantramanav(
                            textStyle: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confirmation code was sent to mobile number",
                          style: GoogleFonts.yantramanav(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 34,
                      ),

                      Form(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 4,
                              obscureText: false,
                              blinkWhenObscuring: false,
                              animationType: AnimationType.scale,
                              validator: (v) {},
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(4),
                                fieldHeight: 50,
                                fieldWidth: 50,
                                selectedColor: Colors.white,
                                selectedFillColor: Colors.transparent,
                                activeFillColor: Colors.transparent,
                                inactiveFillColor: Colors.transparent,
                                errorBorderColor: Colors.transparent,
                                inactiveColor: Colors.grey,
                                disabledColor: Colors.grey,
                                borderWidth: 1,
                                activeColor: Colors.grey,
                              ),
                              cursorColor: Colors.white,
                              animationDuration: Duration(milliseconds: 300),
                              enableActiveFill: true,
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              boxShadows: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (v) {
                                print("Completed");
                              },
                              // onTap: () {
                              //   print("Pressed");
                              // },
                              onChanged: (value) {},
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            )),
                      ),
                      SizedBox(
                        height: 22,
                      ),

                      ///TODO:here
                      timeFinish
                          ? Text(
                              "Retrieve the verification code",
                              style: GoogleFonts.yantramanav(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            )
                          : GestureDetector(
                        onTap: (){
                          navigateToLogin();

                        },
                            child: Text.rich(
                                TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Resend code up ',
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  WidgetSpan(
                                    child: CountdownTimer(
                                      endTime: endTime,
                                      widgetBuilder:
                                          (_, CurrentRemainingTime time) {
                                        if(time.min==0 && time.sec==0){
                                            timeFinish=true;
                                        }
                                        else{
                                            timeFinish=false;
                                        }
                                        if (time != null) {
                                          return Text(
                                            '${time.min ?? 0}'.padLeft(2, '0') +
                                                ':' +
                                                '${time.sec ?? 0}'
                                                    .padLeft(2, '0'),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          );
                                        } else {
                                          return Text('');
                                        }
                                      },
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Other',
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ]),
                              ),
                          ),

                      SizedBox(
                        height: 20,
                      ),
                      (state is LoadedState || state is InitialState ||state is ErrorState)
                          ?RoundedButton(
                        text: "Continues",
                        press: () async {
                          final otpToken = await getOTPToken();

                          BlocProvider.of<OTPCubit>(context)
                              .OTP(textEditingController.text, otpToken);
                        },
                      )
                          :RoundedButtonLoading() ,
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onEnd() {
    print('onEnd');
  }

  void navigateToHome() {
    Navigator.of(context).pushNamed(Home.routeName);
  }

  void navigateToLogin() {
    Navigator.of(context).pop();
  }
}
