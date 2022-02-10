import 'package:json_annotation/json_annotation.dart';
import 'package:aimedic/core/base/base_model.dart';

part 'otp_response_model.g.dart';

@JsonSerializable()
class OTPResponseModel extends BaseModel<OTPResponseModel> {
  String? access_token;
  String? refresh_token;
  String? token_type;


  OTPResponseModel({this.access_token,this.token_type,this.refresh_token});

  @override
  OTPResponseModel fromJson(Map<String, dynamic> json) {
    return _$OTPResponseModelFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$OTPResponseModelToJson(this);
  }
}


// {
//     "app_token": "$2y$10$hLFdM1M8Ft7XdMiDyjhO7uuh5JQWdBOQx9fp31Sr43F9sGEEth36W",
//     "OTPid": 1
// }