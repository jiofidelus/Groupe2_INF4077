import 'package:bloc/bloc.dart';
import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:compiled/failures/index.dart';
import 'package:compiled/failures/location.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final ILocationFacade locationFacade;

  bool serviceEnabled;
  LocationPermission permission;

  LocationCubit({
    @required this.locationFacade,
  }) : super(LocationState());

  locationList() async {
    emit(state.loadingState());
    var r = await locationFacade.getLocations();
    emit(r.fold((l) => state.failureState(l), (r) => state.loadedState(r)));
  }

  getLocation() async {
    emit(state.loadingPreserveState());

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(state.failureState(LocationFailures.DISABLED));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      emit(state.failureState(LocationFailures.GPS_PERMISSION_FOREVER));
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        emit(state.failureState(LocationFailures.GPS_PERMISSION));
        return;
      }
    }

    var r = await Geolocator.getCurrentPosition();
    emit(state.gpsLoadedState(r.longitude, r.latitude));
  }
}
