import 'package:dartz/dartz.dart';
import 'package:testik/core/errors/failures.dart';
import 'package:testik/source/domain/entities/employer.dart';


abstract class EmployerRepo {
  Future<Either<Failure, List<Employer>>> loadFromDataBase();
  Future<Either<Failure, List<Employer>>> loadFromApi();
  Future<Either<Failure, void>> updateData(List<Employer> employers);
}
