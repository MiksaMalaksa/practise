import 'package:dartz/dartz.dart';
import 'package:testik/core/errors/failures.dart';
import 'package:testik/core/usecases/usecase.dart';
import 'package:testik/source/domain/entities/employer.dart';
import 'package:testik/source/domain/repositories/employer_repo.dart';

class LoadFromDb extends UseCase<List<Employer>, NoParams> {
  final EmployerRepo repo;
  LoadFromDb({required this.repo});

  @override
  Future<Either<Failure, List<Employer>>> call(NoParams params) async {
    return repo.loadFromDataBase();
  }
}
