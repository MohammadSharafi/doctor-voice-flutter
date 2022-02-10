
class FileUploadModelRes {
  String? fileName;

  FileUploadModelRes({this.fileName});

  FileUploadModelRes.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = this.fileName;
    return data;
  }

}
