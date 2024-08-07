import 'package:app_barbershop/src/core/restClient/rest_client.dart';
import 'package:app_barbershop/src/model/barbershop_model.dart';
import 'package:app_barbershop/src/model/user_model.dart';
import 'package:app_barbershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:app_barbershop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:app_barbershop/src/repositories/user/user_repository.dart';
import 'package:app_barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:app_barbershop/src/services/users_login/user_login_service.dart';
import 'package:app_barbershop/src/services/users_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../fp/either.dart';
part 'application_providers.g.dart';

//Mantém a intstância rodando -Singleton
@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userloginService(UserloginServiceRef ref) => UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) => BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barbershopRepository.getMyBarberShop(userModel);

  return switch (result) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception,
  };
}
