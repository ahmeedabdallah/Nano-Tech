class FetchCartDataModel {
  String? message;
  int? orderId;
  bool? status;
  int? total;

  FetchCartDataModel({this.message, this.orderId, this.status, this.total});

  FetchCartDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    orderId = json['order_id'];
    status = json['status'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['total'] = this.total;
    return data;
  }
}
