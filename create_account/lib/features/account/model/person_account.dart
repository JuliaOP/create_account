import 'package:create_account/features/account/model/address_model.dart';

class PersonAccount {
  AddressModel? address;
  String? name;
  String? credential;
  String? email;
  String? phone;

  PersonAccount(
      {this.address, this.name, this.credential, this.email, this.phone});

  PersonAccount.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    name = json['name'];
    credential = json['credential'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['name'] = name;
    data['credential'] = credential;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
