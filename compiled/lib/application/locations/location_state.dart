part of 'location_cubit.dart';

class LocationState extends Equatable {
  final List<HLocation> _locations;
  final bool _isLoading;
  final Failure _failure;
  final double _longitude;
  final double _latitude;

  @override
  String toString() {
    return 'LocationState{ _locations: $_locations, _isLoading: $_isLoading, _failure: $_failure, _longitude :$_longitude, _latitude: $_latitude}';
  }

  // Internal constructor
  LocationState._internal(this._locations, this._isLoading, this._failure,
      this._longitude, this._latitude);

  // Initial Factory
  factory LocationState() =>
      new LocationState._internal(null, false, null, null, null);

  // Loading State
  loadingState() {
    return new LocationState._internal(null, true, null, _longitude, _latitude);
  }

  // Loading State
  loadingPreserveState() {
    return new LocationState._internal(
        _locations, true, null, _longitude, _latitude);
  }

  // LoggedIn State
  loadedState(List<HLocation> locations) {
    return new LocationState._internal(
        locations, false, null, _longitude, _latitude);
  }

  // LoggedIn State
  gpsLoadedState(double longitude, double latitude) {
    return new LocationState._internal(
        _locations, false, null, longitude, latitude);
  }

  // Failure State
  failureState(Failure failure) {
    return new LocationState._internal(
        _locations, false, failure, _longitude, _latitude);
  }

// Getters
  bool get isLoggedIn => _locations != null;

  double get longitude => _longitude;
  double get latitude => _latitude;

  bool get failed => _failure != null;

  List<HLocation> get locations => _locations;

  String get errorTitle => _failure?.message;

  String get errorDescription => _failure?.description;

  String get errorHint => _failure?.hint;

  bool get isLoading => _isLoading;

  @override
  // TODO: implement props
  List<Object> get props => [
        _locations,
        _failure,
        _isLoading,
        _longitude,
        _latitude,
      ];
}
