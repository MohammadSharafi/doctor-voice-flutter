import 'dart:async';

import 'package:aimedic/app/otp/cubit/otp_cubit.dart';
import 'package:aimedic/app/otp/model/otp_fail_response_model.dart';
import 'package:aimedic/app/otp/model/otp_request_model.dart';
import 'package:aimedic/app/otp/service/otp_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/home/home.dart';
import 'package:aimedic/app/login/service/login_services.dart';
import 'package:aimedic/core/cache_manager.dart';
import 'package:aimedic/core/network/network_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/otp_response_model.dart';
import '../otp.dart';

abstract class OTPViewModel extends State<OTP>
    with CacheManager, ChangeNotifier {
  late final OTPService otpService;
  final Dio dio = NetworkService.instance.dio;

  @override
  void initState() {
    super.initState();
    otpService = OTPService(dio);
  }

  Future<void> fetchUserOTP(OTPResponseModel response) async {
    if (response.access_token != null) {
      saveToken(response.access_token ?? '');
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(Home.routeName);

      });


    } else if (response.access_token == null) {
      BlocProvider.of<OTPCubit>(context).refresh();

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
