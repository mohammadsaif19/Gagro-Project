// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  Search({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  bool success;
  String message;
  Data data;
  Errors errors;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        success: json["Success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "message": message,
        "data": data.toJson(),
        "errors": errors.toJson(),
      };
}

class Data {
  Data({
    this.dataList,
  });

  DataList dataList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataList: DataList.fromJson(json["data_list"]),
      );

  Map<String, dynamic> toJson() => {
        "data_list": dataList.toJson(),
      };
}

class DataList {
  DataList({
    this.id,
    this.name,
    this.dob,
    this.gender,
    this.occupation,
    this.education,
    this.address,
    this.phone,
    this.image,
    this.type,
    this.upazilaId,
    this.upazilaName,
  });

  int id;
  String name;
  dynamic dob;
  String gender;
  dynamic occupation;
  dynamic education;
  dynamic address;
  String phone;
  dynamic image;
  String type;
  dynamic upazilaId;
  dynamic upazilaName;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        id: json["id"],
        name: json["name"],
        dob: json["dob"],
        gender: json["gender"],
        occupation: json["occupation"],
        education: json["education"],
        address: json["address"],
        phone: json["phone"],
        image: json["image"],
        type: json["type"],
        upazilaId: json["upazila_id"],
        upazilaName: json["upazila_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dob": dob,
        "gender": gender,
        "occupation": occupation,
        "education": education,
        "address": address,
        "phone": phone,
        "image": image,
        "type": type,
        "upazila_id": upazilaId,
        "upazila_name": upazilaName,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
