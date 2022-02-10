class ProfileUploadResponse {
  String? fullName;
  String? gmcNumber;
  String? avatar;

  ProfileUploadResponse({this.fullName, this.gmcNumber, this.avatar});

  ProfileUploadResponse.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    gmcNumber = json['gmc_number'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['gmc_number'] = this.gmcNumber;
    data['avatar'] = this.avatar;
    return data;
  }
}