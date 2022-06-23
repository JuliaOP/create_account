import 'package:create_account/features/account/model/address_model.dart';

import '../../../shared/data/response_data.dart';
import '../data/viacep_repository_impl.dart';

class ViaCepRepositoryInterface {
  ViaCepRepositoryImpl dataService;

  ViaCepRepositoryInterface(this.dataService);

  Future<ResponseData<AddressModel>> getCepInfo(String cep) async {
    return dataService.getCepInfo(cep);
  }
}
