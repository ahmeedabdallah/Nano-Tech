
class ActiveModel {
  Driver? driver;
  int? id;
  List<Items>? items;
  Null? orderChangeDate;
  String? orderDate;
  int? shipping;
  int? status;
  int? subtotal;
  int? tax;
  int? total;

  ActiveModel(
      {this.driver,
        this.id,
        this.items,
        this.orderChangeDate,
        this.orderDate,
        this.shipping,
        this.status,
        this.subtotal,
        this.tax,
        this.total});

  ActiveModel.fromJson(Map<String, dynamic> json) {
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    orderChangeDate = json['order_change_date'];
    orderDate = json['order_date'];
    shipping = json['shipping'];
    status = json['status'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order_change_date'] = this.orderChangeDate;
    data['order_date'] = this.orderDate;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}

class Driver {
  double? latitude;
  double? longitude;
  String? name;
  String? phone;

  Driver({this.latitude, this.longitude, this.name, this.phone});

  Driver.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Items {
  String? description;
  int? id;
  String? imagePath;
  String? name;
  int? price;
  int? quantity;
  double? rating;
  int? totalPrice;

  Items(
      {this.description,
        this.id,
        this.imagePath,
        this.name,
        this.price,
        this.quantity,
        this.rating,
        this.totalPrice});

  Items.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    rating = json['rating'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['rating'] = this.rating;
    data['total_price'] = this.totalPrice;
    return data;
  }
}
