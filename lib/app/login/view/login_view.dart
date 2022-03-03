import 'package:aimedic/app/login/cubit/login_cubit.dart';
import 'package:aimedic/app/login/viewModel/login_view_model.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:aimedic/core/widgets/rounded_button.dart';
import 'package:aimedic/core/widgets/rounded_input.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../core/constants/loading.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum LoginBtnState { Loeded, Loading, InitState, Error }

class LoginView extends LoginViewModel {
  final EdgeInsets paddingLow = EdgeInsets.all(8.0);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controllerPhone = TextEditingController();
  bool isVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkBG,
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoadedState) {
            fetchUserLogin(
              state.response,
            );
          }
          if (state is ErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error!),
              duration: const Duration(seconds: 1),
            ));
          }
          return kIsWeb
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(-1.0, 0.0),
                        end: Alignment(
                          1.0,
                          0.0,
                        ),
                        colors: [
                          AppColors.primaryBlack,
                          AppColors.primaryDarkBlue,
                          AppColors.primaryLightBlue,
                        ],
                        stops: const <double>[0.0, 0.4, 0.9],
                        tileMode: TileMode.decal),
                  ),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/backgroundweb.png',
                          color: Colors.white.withOpacity(0.6),
                          colorBlendMode: BlendMode.modulate,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width),
                      ResponsiveWrapper(
                        maxWidth: 1200,
                        minWidth: 1200,
                        alignment: Alignment.centerLeft,
                        backgroundColor: AppColors.darkBG,
                        mediaQueryData: MediaQueryData(size: Size(1200, 790)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 400,
                                      height: 550,
                                      decoration: BoxDecoration(
                                          color: AppColors.darkBG,
                                          border: Border.all(
                                            color: Colors.grey.shade800,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 300,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/dv.png',
                                                  height: 60,
                                                  width: 60,
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                            SizedBox(height: 40),
                                            Text(
                                              "Login to Doctor Voice",
                                              style: GoogleFonts.yantramanav(
                                                textStyle: TextStyle(
                                                  fontSize: 26,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Text(
                                              "Neuro-Linguistic Programming",
                                              style: GoogleFonts.yantramanav(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: HexColor('#717274'),
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Text(
                                              "Enter your mobile number",
                                              style: GoogleFonts.yantramanav(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      Colors.white.withOpacity(0.8),
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                              width: 300,
                                              child: RoundedInputField(
                                                keyboardType: TextInputType.phone,
                                                onChanged: (String value) {
                                                  if (value.length == 11 &&
                                                      value
                                                          .substring(0, 2)
                                                          .contains('09')) {
                                                    setState(() {
                                                      isVisible = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      isVisible = false;
                                                    });
                                                  }
                                                },
                                                controller: controllerPhone,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Container(
                                              width: 300,
                                              child: RoundedButton(
                                                color: isVisible
                                                    ? AppColors.primaryLightBlue
                                                    : AppColors.primaryDarkBlue,
                                                text: "Login",
                                                press: () {
                                                  if (isVisible) {
                                                    BlocProvider.of<LoginCubit>(
                                                            context)
                                                        .login(
                                                            controllerPhone.text);
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  (state is LoadingState)
                                      ? Center(
                                          child: Container(
                                              width:
                                                  100,
                                              height: 100,
                                              child: Loading.loading),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(width: 300,),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/dv.png',
                                    height: 150,
                                    width: 150,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text.rich(
                                    TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: 'D',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      TextSpan(
                                        text: 'octor ',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      TextSpan(
                                        text: 'V',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      TextSpan(
                                        text: 'oice',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
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
                                    Image.asset(
                                      'assets/images/dv.png',
                                      height: 60,
                                      width: 60,
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
                                    "Login to Doctor Voice",
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
                                    "Neuro-Linguistic Programming",
                                    style: GoogleFonts.yantramanav(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: HexColor('#717274'),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 54,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Enter your mobile number",
                                    style: GoogleFonts.yantramanav(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.8),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                RoundedInputField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (String value) {
                                    if (value.length == 11 &&
                                        value.substring(0, 2).contains('09')) {
                                      setState(() {
                                        isVisible = true;
                                      });
                                    } else {
                                      setState(() {
                                        isVisible = false;
                                      });
                                    }
                                  },
                                  controller: controllerPhone,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                RoundedButton(
                                  color: isVisible
                                      ? AppColors.primaryLightBlue
                                      : AppColors.primaryDarkBlue,
                                  text: "Login",
                                  press: () {
                                    if (isVisible) {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        BlocProvider.of<LoginCubit>(context)
                                            .login(controllerPhone.text);
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: size.height * 0.03),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    (state is LoadingState)
                        ? Center(
                            child: Container(
                                color: AppColors.loadingBg,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Loading.loading),
                          )
                        : Container(),
                  ],
                );
        },
      ),
    );
  }
}
