//     final catalog = catalogFromJson(jsonString);

import 'dart:convert';

Catalog catalogFromJson(String str) => Catalog.fromJson(json.decode(str));

String catalogToJson(Catalog data) => json.encode(data.toJson());

class Catalog {
  Catalog({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  bool success;
  String message;
  Data data;
  Errors errors;

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
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
  String firstPageUrl;
  String lastPageUrl;
  String nextPageUrl;
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
    this.enName,
    this.sku,
    this.quantity,
    this.originalPrice,
    this.price,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.rating,
    this.totalSold,
    this.weight,
    this.colors,
    this.sizes,
    this.createdAt,
    this.canEdit,
    this.categoryId,
    this.category,
    this.totalProduct,
    this.remainingProduct,
  });

  int id;
  String name;
  String enName;
  String sku;
  int quantity;
  int originalPrice;
  int price;
  String description;
  String image1;
  String image2;
  dynamic image3;
  dynamic image4;
  int rating;
  dynamic totalSold;
  Weight weight;
  List<dynamic> colors;
  List<dynamic> sizes;
  CreatedAt createdAt;
  bool canEdit;
  int categoryId;
  String category;
  int totalProduct;
  int remainingProduct;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        id: json["id"],
        name: json["name"],
        enName: json["en_name"] == null ? null : json["en_name"],
        sku: json["sku"],
        quantity: json["quantity"],
        originalPrice: json["original_price"],
        price: json["price"],
        description: json["description"] == null ? null : json["description"],
        image1: json["image1"],
        image2: json["image2"] == null ? null : json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        rating: json["rating"],
        totalSold: json["total_sold"],
        weight: Weight.fromJson(json["weight"]),
        colors: List<dynamic>.from(json["colors"].map((x) => x)),
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        createdAt: createdAtValues.map[json["created_at"]],
        canEdit: json["can_edit"],
        categoryId: json["category_id"],
        category: json["category"],
        totalProduct: json["total_product"],
        remainingProduct: json["remaining_product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "en_name": enName == null ? null : enName,
        "sku": sku,
        "quantity": quantity,
        "original_price": originalPrice,
        "price": price,
        "description": description == null ? null : description,
        "image1": image1,
        "image2": image2 == null ? null : image2,
        "image3": image3,
        "image4": image4,
        "rating": rating,
        "total_sold": totalSold,
        "weight": weight.toJson(),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "created_at": createdAtValues.reverse[createdAt],
        "can_edit": canEdit,
        "category_id": categoryId,
        "category": category,
        "total_product": totalProduct,
        "remaining_product": remainingProduct,
      };
}

enum CreatedAt { THE_03_MARCH_2019, THE_04_MARCH_2019 }

final createdAtValues = EnumValues({
  "03 March,2019": CreatedAt.THE_03_MARCH_2019,
  "04 March,2019": CreatedAt.THE_04_MARCH_2019
});

class Weight {
  Weight({
    this.id,
    this.category,
    this.code,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  Category category;
  Code code;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["id"],
        category: categoryValues.map[json["category"]],
        code: codeValues.map[json["code"]],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": categoryValues.reverse[category],
        "code": codeValues.reverse[code],
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Category { WEIGHT }

final categoryValues = EnumValues({"weight": Category.WEIGHT});

enum Code { KG, UNIT, PIECE }

final codeValues =
    EnumValues({"Kg": Code.KG, "Piece": Code.PIECE, "Unit": Code.UNIT});

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
