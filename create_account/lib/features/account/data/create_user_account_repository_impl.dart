import 'package:create_account/features/account/model/create_user_account_model.dart';
import 'package:create_account/features/account/model/person_account.dart';
import 'package:dio/dio.dart';

import '../../../shared/data/abstract_data_service.dart';
import '../../../shared/data/response_data.dart';

class CreateUserAccountRepositoryImpl extends AbstractDataService {
  Future<ResponseData<CreateUserAccountModel>> registerUserAccount(
      PersonAccount user, String endpoint) async {
    try {
      final dio = Dio();

      String _endpoint =
          endpoint.endsWith('/') ? endpoint + 'users' : '$endpoint/users';

      Response response = await dio.post(_endpoint, data: {
        "address": {
          "zip": user.address!.zipcode,
          "street": user.address!.street,
          "complement":
              user.address!.complement != null ? user.address!.complement : '',
          "neighborhood": user.address!.neighborhood,
          "city": user.address!.city != null ? user.address!.city : '',
          "state": user.address!.state != null ? user.address!.state : '',
          "number": user.address!.number != null ? user.address!.number : '',
        },
        "name": user.name,
        "credential": user.credential,
        "email": user.email,
        "phone": user.phone,
      });

      final _data = CreateUserAccountModel.fromJson(response.data);
      print(_data.toJson());

      return ResponseData<CreateUserAccountModel>(
          data: _data,
          success: true,
          httpCode: response.statusCode,
          httpStatusMessage: response.statusMessage);
    } on DioError catch (dioError) {
      return getDataForDioError<CreateUserAccountModel>(dioError);
    }
  }
}
