part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool _isRestoring;
  final User _user;
  final bool _isLoading;
  final Failure _failure;

  @override
  String toString() {
    return 'AuthState{_isRestoring: $_isRestoring, _user: $_user, _isLoading: $_isLoading, _failure: $_failure}';
  }

  // Internal constructor
  AuthState._internal(
      this._isRestoring, this._user, this._isLoading, this._failure);

  // Initial Factory
  factory AuthState() => new AuthState._internal(true, null, false, null);

  // Loading State
  loadingState() {
    return new AuthState._internal(false, null, true, null);
  }

  // LoggedIn State
  loggedInState(User user) {
    return new AuthState._internal(false, user, false, null);
  }

  // LoggedOut State
  loggedOutState() {
    return new AuthState._internal(false, null, false, null);
  }

  // Failure State
  failureState(Failure failure) {
    return new AuthState._internal(false, _user, false, failure);
  }

// Getters
  bool get isLoggedIn => _user != null;

  bool get failed => _failure != null;

  User get user => _user;

  String get errorTitle => _failure?.message;

  String get errorDescription => _failure?.description;

  String get errorHint => _failure?.hint;

  bool get isLoading => _isLoading;

  bool get isRestoring => _isRestoring;

  @override
  // TODO: implement props
  List<Object> get props => [_user, _failure, _isLoading, _isRestoring];
}
