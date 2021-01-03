import 'dart:math';

import 'package:compiled/domain/auth/i_auth-facade.dart';
import 'package:compiled/domain/auth/user.dart';
import 'package:compiled/failures/auth.dart';
import 'package:compiled/failures/failure.dart';
import 'package:compiled/infracstructure/cache-manager/cache-manager.dart';
import 'package:compiled/infracstructure/network-manager/network-manager.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class AuthFacade implements IAuthFacade {
  final NetworkManager network;
  final CacheManager cache;

  const AuthFacade({
    @required this.network,
    @required this.cache,
  });

  @override
  Future<Either<Failure, User>> loginWithTelephone(String telephone, password) {
    bool shouldFail = Random(DateTime.now().microsecondsSinceEpoch).nextBool();

    return Future.delayed(
        Duration(seconds: 5),
        () => shouldFail
            ? left(AuthFailure.BadRequest)
            : right(User(name: "null", telephone: "null")));
  }
}
