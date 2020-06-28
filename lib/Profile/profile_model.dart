import 'dart:convert';

Gagro gagroFromJson(String str) => Gagro.fromJson(json.decode(str));

String gagroToJson(Gagro data) => json.encode(data.toJson());

class Gagro {
  Gagro({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  bool success;
  String message;
  Data data;
  Errors errors;

  factory Gagro.fromJson(Map<String, dynamic> json) => Gagro(
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
    this.name,
    this.phone,
    this.email,
    this.upazila,
    this.dob,
    this.notice,
    this.gender,
    this.avatar,
    this.address,
    this.education,
    this.organizationId,
    this.organizationName,
    this.nid,
    this.certificate,
    this.nidCopy,
    this.addressProof,
    this.points,
    this.rank,
    this.rating,
    this.roleName,
    this.roleStatus,
    this.basicDone,
    this.avatarDone,
    this.nidCopyDone,
    this.certificateDone,
    this.addressProofDone,
    this.totalProgress,
  });

  String name;
  String phone;
  String email;
  String upazila;
  String dob;
  String notice;
  String gender;
  String avatar;
  String address;
  String education;
  String organizationId;
  String organizationName;
  int nid;
  String certificate;
  String nidCopy;
  String addressProof;
  String points;
  int rank;
  String rating;
  String roleName;
  String roleStatus;
  int basicDone;
  int avatarDone;
  int nidCopyDone;
  int certificateDone;
  int addressProofDone;
  int totalProgress;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        upazila: json["upazila"],
        dob: json["dob"],
        notice: json["notice"],
        gender: json["gender"],
        avatar: json["avatar"],
        address: json["address"],
        education: json["education"],
        organizationId: json["organization_id"],
        organizationName: json["organization_name"],
        nid: json["nid"],
        certificate: json["certificate"],
        nidCopy: json["nid_copy"],
        addressProof: json["address_proof"],
        points: json["points"],
        rank: json["rank"],
        rating: json["rating"],
        roleName: json["role_name"],
        roleStatus: json["role_status"],
        basicDone: json["basicDone"],
        avatarDone: json["avatarDone"],
        nidCopyDone: json["nidCopyDone"],
        certificateDone: json["certificateDone"],
        addressProofDone: json["addressProofDone"],
        totalProgress: json["totalProgress"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "upazila": upazila,
        "dob": dob,
        "notice": notice,
        "gender": gender,
        "avatar": avatar,
        "address": address,
        "education": education,
        "organization_id": organizationId,
        "organization_name": organizationName,
        "nid": nid,
        "certificate": certificate,
        "nid_copy": nidCopy,
        "address_proof": addressProof,
        "points": points,
        "rank": rank,
        "rating": rating,
        "role_name": roleName,
        "role_status": roleStatus,
        "basicDone": basicDone,
        "avatarDone": avatarDone,
        "nidCopyDone": nidCopyDone,
        "certificateDone": certificateDone,
        "addressProofDone": addressProofDone,
        "totalProgress": totalProgress,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
