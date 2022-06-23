import 'package:bloc/bloc.dart';
import 'package:create_account/features/account/model/create_user_account_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/create_user_account_repository_interface.dart';
import '../../model/person_account.dart';

class CreateUserAccountCubit extends Cubit<CreateUserAccountState> {
  final CreateUserAccountRepositoryInterface
      _createUserAccountRepositoryInterface;

  CreateUserAccountCubit(this._createUserAccountRepositoryInterface)
      : super(CreateUserAccountInitialState());

  Future<void> registerUserAccount(PersonAccount user, String endpoint) async {
    await Future.delayed(Duration(microseconds: 0), () async {
      try {
        emit(CreateUserAccountLoadingState());

        var response = await _createUserAccountRepositoryInterface
            .registerUserAccount(user, endpoint);

        if (response.success) {
          emit(CreateUserAccountLoadedState(response.data!));
        } else {
          emit(CreateUserAccountErrorState(response.errorMessage));
        }
      } catch (error) {
        emit(CreateUserAccountErrorState('Erro ao registrar o usuário.'));
      }
    });
  }
}

abstract class CreateUserAccountState {
  const CreateUserAccountState();
}

class CreateUserAccountInitialState extends CreateUserAccountState {
  const CreateUserAccountInitialState();
}

class CreateUserAccountLoadingState extends CreateUserAccountState {
  const CreateUserAccountLoadingState();
}

class CreateUserAccountLoadedState extends CreateUserAccountState {
  final CreateUserAccountModel data;

  CreateUserAccountLoadedState(this.data);

  @override
  List<Object> get props {
    return [data];
  }

  @override
  bool get stringify => true;
}

class CreateUserAccountErrorState extends CreateUserAccountState
    with EquatableMixin {
  final String message;

  CreateUserAccountErrorState(this.message);

  @override
  List<Object> get props {
    return [message];
  }

  @override
  bool get stringify => true;
}
