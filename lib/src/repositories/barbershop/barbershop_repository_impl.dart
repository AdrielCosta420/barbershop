import 'package:app_barbershop/src/core/exceptions/repository_exception.dart';

import 'package:app_barbershop/src/core/fp/either.dart';
import 'package:app_barbershop/src/core/restClient/rest_client.dart';

import 'package:app_barbershop/src/model/barbershop_model.dart';

import 'package:app_barbershop/src/model/user_model.dart';
import 'package:dio/dio.dart';

import 'barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({required this.restClient});
  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarberShop(UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(:data) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {
            'user_id': '#userAuthRef',
          },
        );
        return Success(BarbershopModel.fromMap(data.first));

      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get('/barbershop/${userModel.barbershopId}');
         return Success(BarbershopModel.fromMap(data));
    }
  }
}
