import 'dart:async';

import 'package:aimedic/app/login/cubit/login_cubit.dart';
import 'package:aimedic/app/login/model/user_response_model.dart';
import 'package:aimedic/app/otp/otp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/login/login.dart';
import 'package:aimedic/app/login/service/login_services.dart';
import 'package:aimedic/core/cache_manager.dart';
import 'package:aimedic/core/network/network_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginViewModel extends State<Login>
    with CacheManager, ChangeNotifier {
  late final LoginService loginService;
  final Dio dio = NetworkService.instance.dio;

  @override
  void initState() {
    super.initState();
    loginService = LoginService(dio);
  }

  Future<void> fetchUserLogin(
    UserResponseModel responseModel,
  ) async {
    if (responseModel.otp_token != null) {
      saveOTPToken(responseModel.otp_token ?? '');
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(OTP.routeName);
        BlocProvider.of<LoginCubit>(context).refresh();
      });
    } else if (responseModel.otp_token == null) {
      BlocProvider.of<LoginCubit>(context).refresh();

      scheduleMicrotask(() {
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please Try again",
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w300),
          ),
        );
      });
    }
  }
}
