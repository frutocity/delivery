class OrderResponse {
  String? sId;
  String? user;
  int? number;
  List<Items>? items;
  String? status;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? iV;
  double? lat;
  double? long;

  OrderResponse(
      {this.sId,
      this.user,
      this.number,
      this.items,
      this.status,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.lat,
      this.long});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    number = json['number'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    status = json['status'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['number'] = this.number;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class Items {
  String? product;
  int? quantity;
  String? sId;

  Items({this.product, this.quantity, this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}
