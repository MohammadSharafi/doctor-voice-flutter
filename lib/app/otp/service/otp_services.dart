import 'dart:io';

import 'package:aimedic/app/otp/model/otp_fail_response_model.dart';
import 'package:aimedic/app/otp/model/otp_request_model.dart';
import 'package:aimedic/app/otp/model/otp_response_model.dart';
import 'package:dio/dio.dart';




abstract class IOTPService{
    IOTPService(this.dio);

  Future<OTPResponseModel?> getOTP(OTPRequestModel model);
  final Dio dio;
}

class OTPService extends IOTPService {
  OTPService(Dio dio) : super(dio);

  @override
  Future<OTPResponseModel?> getOTP(OTPRequestModel model) async {
    try {
      final response = await dio.post(OTPPath.OTP.rawValue, data: model,
        options: Options(contentType: Headers.jsonContentType),);


      if (response.statusCode == HttpStatus.ok) {
        return OTPResponseModel().fromJson(response.data);
      }

      return null;
    }on Dio catch(e){
      return null;
    }
  }
  @override
  Future<OTPFailResponseModel?> getFailOTP(OTPRequestModel model) async {
    final response = await dio.post( OTPPath.OTP.rawValue, data: model, options: Options(contentType: Headers.jsonContentType));

    if (response.statusCode == HttpStatus.ok) {
      return OTPFailResponseModel(detail: response.data);
    }

    return null;
  }
}



enum OTPPath { OTP }

extension ServicePathExtension on OTPPath {
  String get rawValue {
    switch (this) {
      case OTPPath.OTP:
        return '/api/v1/auth/access-token';
    }
  }
}
