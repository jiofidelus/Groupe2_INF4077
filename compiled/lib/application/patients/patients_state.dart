part of 'patients_cubit.dart';



class PatientsState extends Equatable {

  final List<Patient> _patients;
  final bool _isLoading;
  final Failure _failure;

  @override
  String toString() {
    return 'PatientsState{_patients: $_patients, _isLoading: $_isLoading, _failure: $_failure}';
  }

  // Internal constructor
  PatientsState._internal(
     this._patients, this._isLoading, this._failure);

  // Initial Factory
  factory PatientsState() => new PatientsState._internal(null, false, null);

  // Loading State
  loadingState() {
    return new PatientsState._internal(null, true, null);
  }

  // LoggedIn State
  loadedState(List<Patient> patients) {
    return new PatientsState._internal(patients, false, null);
  }


  // Failure State
  failureState(Failure failure) {
    return new PatientsState._internal(_patients, false, failure);
  }

// Getters

  bool get failed => _failure != null;

  List<Patient> get patients => _patients;

  String get errorTitle => _failure?.message;

  String get errorDescription => _failure?.description;

  String get errorHint => _failure?.hint;

  bool get isLoading => _isLoading;


  @override
  // TODO: implement props
  List<Object> get props => [_patients, _failure, _isLoading];
}
