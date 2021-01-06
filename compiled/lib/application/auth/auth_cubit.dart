import 'package:bloc/bloc.dart';
import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:compiled/failures/index.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthFacade authFacade;

  AuthCubit({
    @required this.authFacade,
  }) : super(AuthState()) {
    this._restore();
  }

  /// login
  login(String telephone, password) async {
    emit(state.loadingState());
    Println("Here");
    var result = await authFacade.loginWithTelephone(telephone, password);

    emit(result.fold(
      (failure) => state.failureState(failure),
      (user) => state.loggedInState(user),
    ));
  }

  _restore() async {
    Future.delayed(Duration(seconds: 5), () {
      emit(state.loggedOutState());
    });
  }

  logout() async {
    Future.delayed(Duration(seconds: 3), () {
      emit(state.loggedOutState());
    });
  }
}
