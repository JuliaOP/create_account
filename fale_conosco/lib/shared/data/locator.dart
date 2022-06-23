import 'package:create_account/features/account/data/viacep_repository_impl.dart';
import 'package:create_account/features/account/presentation/bloc/viacep_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/account/data/create_user_account_repository_impl.dart';
import '../../features/account/domain/create_user_account_repository_interface.dart';
import '../../features/account/domain/viacep_repository_interface.dart';
import '../../features/account/presentation/bloc/create_user_account_bloc.dart';

GetIt getIt = GetIt.instance;

void getSetupLocator() {
  {
    // ViaCep
    getIt.registerSingleton<ViaCepRepositoryImpl>(ViaCepRepositoryImpl(),
        signalsReady: true);
    getIt.registerSingleton<ViaCepRepositoryInterface>(
        ViaCepRepositoryInterface(getIt.get<ViaCepRepositoryImpl>()),
        signalsReady: true);
    getIt.registerFactory<ViaCepCubit>(
        () => ViaCepCubit(getIt.get<ViaCepRepositoryInterface>()));
  }

  {
    // CreateUserAccount
    getIt.registerSingleton<CreateUserAccountRepositoryImpl>(
        CreateUserAccountRepositoryImpl(),
        signalsReady: true);
    getIt.registerSingleton<CreateUserAccountRepositoryInterface>(
        CreateUserAccountRepositoryInterface(
            getIt.get<CreateUserAccountRepositoryImpl>()),
        signalsReady: true);
    getIt.registerFactory<CreateUserAccountCubit>(() => CreateUserAccountCubit(
        getIt.get<CreateUserAccountRepositoryInterface>()));
  }
}
