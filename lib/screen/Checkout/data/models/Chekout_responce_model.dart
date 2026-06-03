import 'checkout_model.dart';

class FetchCartDataModel {
  Orders? orders;
  bool? status;

  FetchCartDataModel({this.orders, this.status});

  FetchCartDataModel.fromJson(Map<String, dynamic> json) {
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Orders {
  List<ActiveModel>? active;
  List<Null>? canceled;
  List<Null>? completed;

  Orders({this.active, this.canceled, this.completed});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['active'] != null) {
      active = <ActiveModel>[];
      json['active'].forEach((v) {
        active!.add(new ActiveModel.fromJson(v));
      });
    }
   if (json['canceled'] != null) {
      canceled = <Null>[];
      json['canceled'].forEach((v) {
      //  canceled!.add(new Null.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <Null>[];
      json['completed'].forEach((v) {
        //completed!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.active != null) {
      data['active'] = this.active!.map((v) => v.toJson()).toList();
    }
    if (this.canceled != null) {
     // data['canceled'] = this.canceled!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
     // data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



