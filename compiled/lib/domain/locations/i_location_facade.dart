import 'package:compiled/domain/locations/location-model.dart';
import 'package:compiled/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ILocationFacade {
  Future<Either<Failure, HLocation>> getLocationByID(int id);
  Future<Either<Failure, List<HLocation>>> getLocations();
  Future<Either<Failure, HLocation>> getLocationFromCoordinate(
      double lat, double long);
  Future<Either<Failure, HLocation>> getCurrentCoordinate();
}
