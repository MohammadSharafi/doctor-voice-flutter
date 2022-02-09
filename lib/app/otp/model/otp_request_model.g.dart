// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPRequestModel _$OTPRequestModelFromJson(Map<String, dynamic> json) {
  return OTPRequestModel(
    code: json['code'] as String?,
    otp_token: json['otp_token'] as String?,
  );
}

Map<String, dynamic> _$OTPRequestModelToJson(OTPRequestModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'otp_token': instance.otp_token,
    };
