import 'package:craftybay/data/models/categori_data.dart';

class CategoriModel {
  String? msg;
  List<CategoriData>? data;

  CategoriModel({this.msg, this.data});

  CategoriModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CategoriData>[];
      json['data'].forEach((v) {
        data!.add(CategoriData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

