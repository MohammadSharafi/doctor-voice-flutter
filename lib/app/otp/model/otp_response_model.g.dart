// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResponseModel _$OTPResponseModelFromJson(Map<String, dynamic> json) {
  return OTPResponseModel(
    access_token: json['access_token'] as String?,
    token_type: json['token_type'] as String?,
    refresh_token: json['refresh_token'] as String?,
  );
}

Map<String, dynamic> _$OTPResponseModelToJson(OTPResponseModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'refresh_token': instance.refresh_token,
    };
