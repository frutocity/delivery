import 'dart:convert';

void main() {
  var apiData = {
    "status": true,
    "message": "Product Data",
    "data": {
      "_id": "62c5c26bc41e3c95d25830c8",
      "name": "Fresho Banana - Robusta",
      "description":
          "Relish the soft, buttery texture of Robusta bananas that are light green and have a great fragrance and taste.",
      "photo": ["https://assets.frutocity.com/1657127340712.jpeg"],
      "price": 25,
      "unit": {
        "_id": "62c1d3e7c41e3c95d258302b",
        "name": "KG",
        "createdAt": "2022-07-03T17:37:43.899Z",
        "updatedAt": "2022-07-03T17:37:43.899Z",
        "__v": 0
      },
      "unit_value": 0,
      "weight": "1kg++",
      "category": {
        "_id": "62c1d3dfc41e3c95d2583026",
        "name": "Fruits",
        "description": "Best Quality Fruits",
        "photo": "https://assets.frutocity.com/1656869844303.jpg",
        "active": true,
        "createdAt": "2022-07-03T17:37:35.658Z",
        "updatedAt": "2022-07-03T17:37:35.658Z",
        "__v": 0
      },
      "quantity": 20,
      "details": [
        {"title": "", "description": ""}
      ],
      "discount": 10,
      "store": {
        "_id": "62c1d41af49bc4915c95ff03",
        "name": "Vaishali Nagar",
        "address": "B72, nahri ka naka, madina masjid road Jaipur",
        "apartment": "Ridhi Sidhi",
        "city": "Jaipur",
        "state": "Rājasthān",
        "pin_code": 302016,
        "employee_count": 19,
        "createdAt": "2022-07-03T17:38:34.752Z",
        "updatedAt": "2022-07-03T17:38:34.752Z",
        "__v": 0
      },
      "active": true,
      "createdAt": "2022-07-06T17:12:11.615Z",
      "updatedAt": "2022-07-06T17:12:11.615Z",
      "__v": 0
    }
  };

  ProductByIdResponse.fromJson(apiData);
}

ProductByIdResponse ProductByIdResponseFromJson(String str) =>
    ProductByIdResponse.fromJson(json.decode(str));

class ProductByIdResponse {
  ProductByIdResponse({
    required this.status,
    required this.message,
    this.data,
  });

  final bool status;
  final String message;
  final Product? data;

  factory ProductByIdResponse.fromJson(Map<String, dynamic> json) =>
      ProductByIdResponse(
        status: json["status"],
        message: json["message"],
        data: Product.fromJson(json),
      );
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.price,
    required this.unit,
    required this.unitValue,
    required this.weight,
    required this.category,
    required this.quantity,
    // this.details,
    required this.discount,
    required this.store,
    required this.active,
    this.meta,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String description;
  final List<String> photo;
  final int price;
  final Unit unit;
  final int unitValue;
  final String weight;
  final Category category;
  final int quantity;
  // final List<Detail>? details;
  final int discount;
  final Store store;
  final bool active;
  final dynamic meta;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: List<String>.from(json["photo"].map((x) => x)),
        price: json["price"],
        unit: Unit.fromJson(json["unit"]),
        unitValue: json["unit_value"],
        weight: json["weight"],
        category: Category.fromJson(json["category"]),
        quantity: json["quantity"],
        // details:
        //     List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        discount: json["discount"],
        store: Store.fromJson(json["store"]),
        active: json["active"],
        meta: json["meta"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": List<dynamic>.from(photo.map((x) => x)),
        "price": price,
        "unit": unit.toJson(),
        "unit_value": unitValue,
        "weight": weight,
        "category": category.toJson(),
        "quantity": quantity,
        // "details": List<dynamic>.from((details ?? []).map((x) => x.toJson())),
        "discount": discount,
        "store": store.toJson(),
        "active": active,
        "meta": meta,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String description;
  final String photo;
  final bool active;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        active: json["active"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": photo,
        "active": active,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class Detail {
  Detail({
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.apartment,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.employeeCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String address;
  final String apartment;
  final String city;
  final String state;
  final int pinCode;
  final int employeeCount;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        apartment: json["apartment"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pin_code"],
        employeeCount: json["employee_count"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "apartment": apartment,
        "city": city,
        "state": state,
        "pin_code": pinCode,
        "employee_count": employeeCount,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class Unit {
  Unit({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
