import 'dart:developer';
import 'dart:io';

import 'package:app_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:app_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:app_barbershop/src/model/user_model.dart';
import 'package:dio/dio.dart';

import '../../core/fp/either.dart';
import '../../core/restClient/rest_client.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});
  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
    try {
      log('entrou no repository login');
      final Response(:data) = await restClient.unAuth.post('/auth', data: {'email': email, 'password': password});
      log('data do repository login: $data');

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos');
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuario logado', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid JSON', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
