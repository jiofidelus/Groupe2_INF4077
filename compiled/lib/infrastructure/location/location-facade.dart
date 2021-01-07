import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/locations/location-model.dart';
import 'package:compiled/failures/codes.dart';
import 'package:compiled/failures/failure.dart';
import 'package:compiled/failures/location.dart';
import 'package:compiled/infrastructure/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:meta/meta.dart';

class LocationFacade implements ILocationFacade {
  List<HLocation> locationCache;
  final FileManager fileManager;
  final reverseGeoCoding = ReverseGeoCoding(
    apiKey:
        'pk.eyJ1IjoieXZlc2pvcmRhMDYiLCJhIjoiY2tqbTg4Y2s4MmFwMDJ5bG9yZ2JnYzNsaSJ9.l45zY7JDP1-qJDr2XREwZQ',
    limit: 1,
  );

  bool serviceEnabled;
  LocationPermission permission;

  LocationFacade({
    @required this.fileManager,
  });

  @override
  Future<Either<Failure, HLocation>> getLocationByID(int id) async {
    HLocation r;

    if (locationCache == null) {
      var locationMap =
          await fileManager.jsonFileToMapList("assets/mocks/regions.json");
      locationCache = locationMap.map((e) => HLocation.fromMap(e)).toList();
    }

    r = locationCache.firstWhere((element) => element.id == id);
    if (r != null) {
      return right(r);
    } else {
      return left(Failure(
          code: FailureCodes.NotFound,
          message: "Location not found",
          description: "The location you are looking doesn't exist"));
    }
  }

  @override
  Future<Either<Failure, List<HLocation>>> getLocations() async {
    if (locationCache == null) {
      var locationMap =
          await fileManager.jsonFileToMapList("assets/mocks/regions.json");
      locationCache = locationMap.map((e) => HLocation.fromMap(e)).toList();
    }

    return right(locationCache);
  }

  @override
  Future<Either<Failure, HLocation>> getCurrentCoordinate() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return left(LocationFailures.DISABLED);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return left(LocationFailures.GPS_PERMISSION_FOREVER);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return left(LocationFailures.GPS_PERMISSION);
      }
    }

    var r = await Geolocator.getCurrentPosition();
    List<MapBoxPlace> r2;
    try {
      r2 = await reverseGeoCoding.getAddress(Location(lat: 72.0, lng: 76.00));
    } catch (_) {
      r2 = null;
    }

    if (r2.isEmpty || r2 == null) {
      return right(new HLocation(
          name: "Unknown",
          code: "UKN",
          id: -1,
          long: r.longitude,
          lat: r.latitude));
    }
    var fi = r2.first;

    var hLocation = new HLocation(
        name: fi.placeName,
        code: fi.text,
        id: 0,
        lat: r.latitude,
        long: r.longitude);

    return right(hLocation);
  }

  @override
  Future<Either<Failure, HLocation>> getLocationFromCoordinate(
      double lat, double long) async {
    var r = await reverseGeoCoding.getAddress(
      Location(lat: lat, lng: long),
    );

    print(r.first.placeName);
    print(r);
  }
}
