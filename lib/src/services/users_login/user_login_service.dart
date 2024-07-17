import 'package:app_barbershop/src/core/fp/either.dart';
import 'package:app_barbershop/src/core/fp/nil.dart';

import '../../core/exceptions/service_exception.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
