class Dashboard {
  num? submittedTextCount;
  num? timeRecorded;
  num? score;
  num? confirmedCount;
  num? pendingCount;
  num? failedCount;

  Dashboard(
      {this.submittedTextCount,
        this.timeRecorded,
        this.score,
        this.confirmedCount,
        this.pendingCount,
        this.failedCount});

  Dashboard.fromJson(Map<String, dynamic> json) {
    submittedTextCount = json['submitted_text_count'];
    timeRecorded = json['time_recorded'];
    score = json['score'];
    confirmedCount = json['confirmed_count'];
    pendingCount = json['pending_count'];
    failedCount = json['failed_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['submitted_text_count'] = this.submittedTextCount;
    data['time_recorded'] = this.timeRecorded;
    data['score'] = this.score;
    data['confirmed_count'] = this.confirmedCount;
    data['pending_count'] = this.pendingCount;
    data['failed_count'] = this.failedCount;
    return data;
  }
}