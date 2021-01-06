import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/locations/location-model.dart';
import 'package:compiled/failures/codes.dart';
import 'package:compiled/failures/failure.dart';
import 'package:compiled/infrastructure/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class LocationFacade implements ILocationFacade{
  List<Location> locationCache;
  final FileManager fileManager;

  LocationFacade({
    @required this.fileManager,
  });

  @override
  Future<Either<Failure, Location>> getLocationByID(int id) async{
    Location r;


   if(locationCache == null) {
      var locationMap = await fileManager.jsonFileToMapList("assets/mocks/regions.json");
      locationCache = locationMap.map((e) => Location.fromMap(e)).toList();
    }

    r = locationCache.firstWhere((element) => element.id == id);
    if (r != null) {
      return right(r);
    } else {
      return left(Failure(code: FailureCodes.NotFound, message: "Location not found", description: "The location you are looking doesn't exist"));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> getLocations() async{
    if(locationCache == null) {
      var locationMap = await fileManager.jsonFileToMapList("assets/mocks/regions.json");
      locationCache = locationMap.map((e) => Location.fromMap(e)).toList();
    }

    return right(locationCache);
  }
}
