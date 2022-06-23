import 'package:create_account/features/account/model/address_model.dart';
import 'package:dio/dio.dart';

import '../../../shared/data/abstract_data_service.dart';
import '../../../shared/data/response_data.dart';

class ViaCepRepositoryImpl extends AbstractDataService {
  Future<ResponseData<AddressModel>> getCepInfo(String cep) async {
    try {
      var _cep = cep.replaceAll('-', '');
      _cep = _cep.replaceAll('.', '');

      final dio = Dio();
      Response response = await dio.get('https://viacep.com.br/ws/$_cep/json/');

      final _data = AddressModel.fromJson(response.data);

      return ResponseData<AddressModel>(
          data: _data,
          success: true,
          httpCode: response.statusCode,
          httpStatusMessage: response.statusMessage);
    } on DioError catch (dioError) {
      return getDataForDioError<AddressModel>(dioError);
    }
  }
}
