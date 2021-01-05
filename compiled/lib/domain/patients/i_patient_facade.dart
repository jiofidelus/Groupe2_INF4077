import 'package:compiled/failures/failure.dart';
import 'package:dartz/dartz.dart';

import 'patient_model.dart';

abstract class IPatientFacade{
  Future<Either<Failure, List<Patient>>> getAllPatient();


}
