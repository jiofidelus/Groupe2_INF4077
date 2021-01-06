import 'package:bloc/bloc.dart';
import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:compiled/failures/index.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final ILocationFacade locationFacade;

   LocationCubit({
    @required this.locationFacade,
  }): super(LocationState());



  locationList() async{
    emit(state.loadingState());
    var r = await locationFacade.getLocations();
    emit(r.fold((l) => state.failureState(l), (r) => state.loadedState(r)));
  }
}
