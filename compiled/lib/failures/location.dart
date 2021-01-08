import 'package:compiled/failures/codes.dart';
import 'package:compiled/failures/failure.dart';

abstract class LocationFailures {
  static const GPS_PERMISSION = Failure(
      code: FailureCodes.Unknown,
      message: "Could not found location",
      description: "Does not have enough permission to use the GPS");

  static const GPS_PERMISSION_FOREVER = Failure(
      code: FailureCodes.Unknown,
      message: "GPS Permission permenantly disabled",
      description: "Please activate GPS permission from your settings");

  static const GOOGLE_SERVICES = Failure(
      code: FailureCodes.Unknown,
      message: "Could not found location",
      description: "Google play services required");

  static const DISABLED = Failure(
      code: FailureCodes.Unknown,
      message: "Location services are disabled.",
      description: "Please activate the location services");
}
