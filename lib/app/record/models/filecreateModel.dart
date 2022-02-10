class createVoiceModel {
  String? url;
  String? textId;

  createVoiceModel({this.url, this.textId});

  createVoiceModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    textId = json['text_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text_id'] = this.textId;
    return data;
  }
}