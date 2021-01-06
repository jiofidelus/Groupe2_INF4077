import 'package:compiled/domain/auth/user.dart';
import 'package:compiled/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthFacade {
  Future<Either<Failure, User>> loginWithTelephone(
      String telephone, String password);
}
