class OTPFailResponseModel {
  OTPFailResponseModel({
    required this.detail,
  });

  late final List<Detail> detail;

  OTPFailResponseModel.fromJson(Map<String, dynamic> json) {
    detail = List.from(json['detail']).map((e) => Detail.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['detail'] = detail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Detail {
  Detail({
    required this.loc,
    required this.msg,
    required this.type,
  });

  late final List<String> loc;
  late final String msg;
  late final String type;

  Detail.fromJson(Map<String, dynamic> json) {
    loc = List.castFrom<dynamic, String>(json['loc']);
    msg = json['msg'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loc'] = loc;
    _data['msg'] = msg;
    _data['type'] = type;
    return _data;
  }
}
