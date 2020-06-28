class Gagro {
  bool success;
  String message;
  Data data;
  Errors errors;

  Gagro({this.success, this.message, this.data, this.errors});

  Gagro.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class Data {
  List<DataList> dataList;

  Data({this.dataList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data_list'] != null) {
      dataList = new List<DataList>();
      json['data_list'].forEach((v) {
        dataList.add(new DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataList != null) {
      data['data_list'] = this.dataList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataList {
  int id;
  String name;
  String image;
  String description;
  List<Child> childList;

  DataList({this.id, this.name, this.image, this.description, this.childList});

  DataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    if (json['child'] != null) {
      childList = new List<Child>();
      json['child'].forEach((v) {
        childList.add(new Child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.childList != null) {
      data['child'] = this.childList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  int id;
  String name;
  String image;
  String description;
  List<Child2> child;

  Child({this.id, this.name, this.image, this.description, this.child});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    if (json['child'] != null) {
      child = new List<Child2>();
      json['child'].forEach((v) {
        child.add(new Child2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.child != null) {
      data['child'] = this.child.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child2 {
  int id;
  String name;
  String image;
  String description;
  List<dynamic> child;

  Child2({this.id, this.name, this.image, this.description, this.child});

  Child2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    if (json['child'] != null) {
      child = new List<dynamic>();
//      json['child'].forEach((v) { child.add(new Object.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.child != null) {
      data['child'] = this.child.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  Errors();

  Errors.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
