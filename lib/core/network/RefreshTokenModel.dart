class RefreshTokenModel {
  String? accessToken;
  String? refreshToken;
  String? tokenType;

  RefreshTokenModel({this.accessToken, this.refreshToken, this.tokenType});

  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}