import 'package:bloc/bloc.dart';
import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:compiled/failures/index.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'gps_state.dart';

class GPSCubit extends Cubit<GPSState> {
  final ILocationFacade locationFacade;

  GPSCubit({
    @required this.locationFacade,
  }) : super(GPSState());

  getLocation() async {
    emit(state.loadingState());

    var r = await locationFacade.getCurrentCoordinate();
    emit(r.fold((l) => state.failureState(l), (r) => state.loadedState(r)));
  }
}
