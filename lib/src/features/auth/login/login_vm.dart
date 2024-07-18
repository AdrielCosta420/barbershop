import 'package:app_barbershop/src/core/exceptions/service_exception.dart';
import 'package:app_barbershop/src/core/fp/either.dart';
import 'package:app_barbershop/src/features/auth/login/login_state.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/application_providers.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();
    final loginService = ref.watch(userloginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():
        //buscar dados do user logado
        // fazer uma analise para ql o tipo de login
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(status: LoginStateStatus.error, errorMessage: () => message);
    }
    loaderHandle.close();
  }
}