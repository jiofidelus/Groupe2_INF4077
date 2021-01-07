part of 'gps_cubit.dart';

class GPSState extends Equatable {
  final HLocation _location;
  final bool _isLoading;
  final Failure _failure;

  @override
  String toString() {
    return 'GPSState{ _location: $_location, _isLoading: $_isLoading, _failure: $_failure}';
  }

  // Internal constructor
  GPSState._internal(
    this._location,
    this._isLoading,
    this._failure,
  );

  // Initial Factory
  factory GPSState() => new GPSState._internal(null, false, null);

  // Loading State
  loadingState() {
    return new GPSState._internal(null, true, null);
  }

  // LoggedIn State
  loadedState(HLocation location) {
    return new GPSState._internal(
      location,
      false,
      null,
    );
  }

  // Failure State
  failureState(Failure failure) {
    return new GPSState._internal(_location, false, failure);
  }

// Getters

  double get longitude => _location?.long;

  double get latitude => _location?.lat;

  bool get failed => _failure != null;

  HLocation get location => _location;

  String get errorTitle => _failure?.message;

  String get errorDescription => _failure?.description;

  String get errorHint => _failure?.hint;

  bool get isLoading => _isLoading;

  @override
  // TODO: implement props
  List<Object> get props => [
        _location,
        _failure,
        _isLoading,
      ];
}
