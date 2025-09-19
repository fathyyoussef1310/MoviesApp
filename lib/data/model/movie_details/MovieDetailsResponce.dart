import '../movie_list/@meta.dart';
import 'Data.dart';

class MovieDetailsResponse {
  MovieDetailsResponse({this.status, this.statusMessage, this.data, this.meta});

  MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? MetaData.fromJson(json['@meta']) : null;
  }

  String? status;
  String? statusMessage;
  Data? data;
  MetaData? meta;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_message': statusMessage,
      if (data != null) 'data': data?.toJson(),
      if (meta != null) '@meta': meta?.toJson(),
    };
  }
}
