class CreateUserAccountModel {
  String? userId;
  String? name;
  String? phone;

  CreateUserAccountModel({this.userId, this.name, this.phone});

  CreateUserAccountModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
