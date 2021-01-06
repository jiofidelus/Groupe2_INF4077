import 'package:compiled/domain/locations/location-model.dart';
import 'package:compiled/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ILocationFacade{
    Future<Either<Failure, Location>> getLocationByID(int id);
    Future<Either<Failure, List<Location>>> getLocations();
}
