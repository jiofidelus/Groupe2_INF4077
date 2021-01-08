import 'package:bloc/bloc.dart';
import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:compiled/failures/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  final IPatientFacade patientFacade;
  PatientsCubit({@required this.patientFacade}) : super(PatientsState());

  allPatient() async {
    emit(state.loadingState());
    var s = await patientFacade.getAllPatient();
    emit(s.fold((l) => state.failureState(l), (r) => state.loadedState(r)));
  }

  createPatient(Patient patient) async {
    emit(state.loadingState());
    await patientFacade.addPatient(patient);
    await allPatient();
  }
}
