class TextListModel {
  String? text;
  String? id;
  bool? is_recorded;

  TextListModel({this.text, this.id,this.is_recorded,});

  TextListModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    id = json['id'];
    is_recorded = json['is_recorded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['id'] = this.id;
    data['is_recorded'] = this.is_recorded;
    return data;
  }
}
