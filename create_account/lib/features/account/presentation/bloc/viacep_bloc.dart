import 'package:bloc/bloc.dart';
import 'package:create_account/features/account/domain/viacep_repository_interface.dart';
import 'package:create_account/features/account/model/address_model.dart';
import 'package:equatable/equatable.dart';

class ViaCepCubit extends Cubit<ViaCepState> {
  final ViaCepRepositoryInterface _viaCepRepositoryInterface;

  ViaCepCubit(this._viaCepRepositoryInterface) : super(ViaCepInitialState());

  Future<void> getCepInfo(String cep) async {
    await Future.delayed(Duration(microseconds: 0), () async {
      try {
        emit(ViaCepLoadingState());

        var response = await _viaCepRepositoryInterface.getCepInfo(cep);

        if (response.success) {
          emit(ViaCepLoadedState(response.data!));
        } else {
          emit(ViaCepErrorState(response.errorMessage));
        }
      } catch (error) {
        emit(ViaCepErrorState('Erro ao pesquisar o CEP'));
      }
    });
  }
}

abstract class ViaCepState {
  const ViaCepState();
}

class ViaCepInitialState extends ViaCepState {
  const ViaCepInitialState();
}

class ViaCepLoadingState extends ViaCepState {
  const ViaCepLoadingState();
}

class ViaCepLoadedState extends ViaCepState {
  final AddressModel data;

  ViaCepLoadedState(this.data);

  @override
  List<Object> get props {
    return [data];
  }

  @override
  bool get stringify => true;
}

class ViaCepErrorState extends ViaCepState with EquatableMixin {
  final String message;

  ViaCepErrorState(this.message);

  @override
  List<Object> get props {
    return [message];
  }

  @override
  bool get stringify => true;
}
