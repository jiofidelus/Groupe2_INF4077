part of 'location_cubit.dart';

class LocationState extends Equatable {

  final List<Location> _locations;
  final bool _isLoading;
  final Failure _failure;

  @override
  String toString() {
    return 'LocationState{ _locations: $_locations, _isLoading: $_isLoading, _failure: $_failure}';
  }

  // Internal constructor
  LocationState._internal(
     this._locations, this._isLoading, this._failure);

  // Initial Factory
  factory LocationState() => new LocationState._internal(null, false, null);

  // Loading State
  loadingState() {
    return new LocationState._internal(null, true, null);
  }

  // LoggedIn State
  loadedState(List<Location> locations) {
    return new LocationState._internal(locations, false, null);
  }



  // Failure State
  failureState(Failure failure) {
    return new LocationState._internal(_locations, false, failure);
  }

// Getters
  bool get isLoggedIn => _locations != null;

  bool get failed => _failure != null;

  List<Location> get locations => _locations;

  String get errorTitle => _failure?.message;

  String get errorDescription => _failure?.description;

  String get errorHint => _failure?.hint;

  bool get isLoading => _isLoading;


  @override
  // TODO: implement props
  List<Object> get props => [_locations, _failure, _isLoading,];
}
