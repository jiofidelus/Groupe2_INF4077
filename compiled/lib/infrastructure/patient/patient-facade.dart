import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/domain/patients/patient_model.dart';
import 'package:compiled/failures/failure.dart';
import 'package:compiled/infrastructure/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class PatientFacade implements IPatientFacade {
  final FileManager fileManager;
  static const ALL_PATIENT = 'assets/mocks/patients.json';

  const PatientFacade({
    @required this.fileManager,
  });

  @override
  Future<Either<Failure, List<Patient>>> getAllPatient() async {
    List<dynamic> jsonResult = await fileManager.jsonFileToMapList(ALL_PATIENT);
    return right(jsonResult.map((e) => Patient.fromMap(e)).toList());
  }

  @override
  Future<Either<Failure, Patient>> addPatient(Patient patient) async {
    await fileManager.addToJsonMapList(patient.toMap(), ALL_PATIENT);
  }
}
