class AddressModel {
  String? zipcode;
  String? street;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;
  String? number;

  AddressModel(
      {this.zipcode,
      this.street,
      this.complement,
      this.neighborhood,
      this.city,
      this.state,
      this.number});

  AddressModel.fromJson(Map<String, dynamic> json) {
    zipcode = json['cep'];
    street = json['logradouro'];
    complement = json['complemento'];
    neighborhood = json['bairro'];
    city = json['localidade'];
    state = json['uf'];
    number = json['numero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = zipcode;
    data['logradouro'] = street;
    data['complemento'] = complement;
    data['bairro'] = neighborhood;
    data['localidade'] = city;
    data['uf'] = state;
    data['numero'] = number;
    return data;
  }
}
