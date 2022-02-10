class VoiceListItem {
  String? url;
  String? textId;
  String? status;
  String? id;
  VoiceText? text;
  String? created_at;

  VoiceListItem({this.url, this.textId, this.status, this.id, this.text,this.created_at});

  VoiceListItem.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    textId = json['text_id'];
    status = json['status'];
    id = json['id'];
    created_at = json['created_at'];
    text = json['text'] != null ? new VoiceText.fromJson(json['text']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text_id'] = this.textId;
    data['status'] = this.status;
    data['id'] = this.id;
    data['created_at'] = this.created_at;
    if (this.text != null) {
      data['text'] = this.text!.toJson();
    }
    return data;
  }
}

class VoiceText {
  String? text;
  String? id;

  VoiceText({this.text, this.id});

  VoiceText.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['id'] = this.id;
    return data;
  }
}