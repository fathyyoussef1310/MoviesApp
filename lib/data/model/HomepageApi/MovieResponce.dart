import '@meta.dart';
import 'Data.dart';

class MoviesResponce {
  MoviesResponce({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  MoviesResponce.fromJson(dynamic json) {
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
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }
}
