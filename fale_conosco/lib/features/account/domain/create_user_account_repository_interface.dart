import '../../../shared/data/response_data.dart';
import '../data/create_user_account_repository_impl.dart';
import '../model/create_user_account_model.dart';
import '../model/person_account.dart';

class CreateUserAccountRepositoryInterface {
  CreateUserAccountRepositoryImpl dataService;

  CreateUserAccountRepositoryInterface(this.dataService);

  Future<ResponseData<CreateUserAccountModel>> registerUserAccount(
      PersonAccount user, String endpoint) async {
    return dataService.registerUserAccount(user, endpoint);
  }
}
