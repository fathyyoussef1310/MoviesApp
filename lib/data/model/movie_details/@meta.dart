class MetaData {
  MetaData({this.serverTime, this.serverTimezone, this.apiVersion, this.executionTime});

  MetaData.fromJson(Map<String, dynamic> json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

  int? serverTime;
  String? serverTimezone;
  int? apiVersion;
  String? executionTime;

  Map<String, dynamic> toJson() {
    return {
      'server_time': serverTime,
      'server_timezone': serverTimezone,
      'api_version': apiVersion,
      'execution_time': executionTime,
    };
  }
}
