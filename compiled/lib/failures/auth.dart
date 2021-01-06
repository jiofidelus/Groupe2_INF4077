import 'package:compiled/failures/codes.dart';
import 'package:compiled/failures/failure.dart';

abstract class AuthFailure extends Failure {
  static const BadRequest =
      Failure(code: FailureCodes.Unknown, message: "Login failed");
}
