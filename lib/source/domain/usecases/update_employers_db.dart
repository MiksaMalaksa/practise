import 'package:dartz/dartz.dart';
import 'package:testik/core/errors/failures.dart';
import 'package:testik/core/usecases/usecase.dart';
import 'package:testik/source/domain/entities/employer.dart';
import 'package:testik/source/domain/repositories/employer_repo.dart';

class UpdateToDb extends UseCase<void, List<Employer>> {
  final EmployerRepo repo;
  UpdateToDb({required this.repo});

  @override
  Future<Either<Failure, void>> call(List<Employer> params) async {
    await repo.updateData(params);
    return const Right(null);
  }
}
