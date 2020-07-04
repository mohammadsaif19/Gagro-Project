import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  bool success;
  String message;
  Data data;
  Errors errors;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
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
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
    this.dataList,
  });

  int total;
  int perPage;
  int currentPage;
  int lastPage;
  dynamic firstPageUrl;
  dynamic lastPageUrl;
  dynamic nextPageUrl;
  dynamic prevPageUrl;
  List<DataList> dataList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        firstPageUrl: json["first_page_url"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
        dataList: List<DataList>.from(
            json["data_list"].map((x) => DataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
        "first_page_url": firstPageUrl,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "data_list": List<dynamic>.from(dataList.map((x) => x.toJson())),
      };
}

class DataList {
  DataList({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.total,
    this.image,
  });

  int id;
  String name;
  int price;
  String quantity;
  int total;
  String image;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "total": total,
        "image": image,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
