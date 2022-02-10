import 'package:json_annotation/json_annotation.dart';
import 'package:aimedic/core/base/base_model.dart';

part 'otp_request_model.g.dart';

@JsonSerializable()
class OTPRequestModel extends BaseModel<OTPRequestModel> {
  String? code;
  String? otp_token;

  OTPRequestModel({this.code,this.otp_token});

  @override
  fromJson(Map<String, dynamic> json) {
    return _$OTPRequestModelFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$OTPRequestModelToJson(this);
  }
}
