import 'package:create_account/features/account/data/viacep_repository_impl.dart';
import 'package:create_account/features/account/presentation/bloc/viacep_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/account/domain/viacep_repository_interface.dart';

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
}
