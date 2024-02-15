import 'package:dartz/dartz.dart';
import 'package:testik/core/errors/exeptions.dart';
import 'package:testik/core/errors/failures.dart';
import 'package:testik/source/data/data_sources/local_data_source/i_local_data_source.dart';
import 'package:testik/source/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:testik/source/domain/entities/employer.dart';
import 'package:testik/source/domain/repositories/employer_repo.dart';

class EmployerRepoImpl extends EmployerRepo {
  final ILocalDataSource _localDataSrc;
  final RemoteDataSource _remoteDataSrc;

  EmployerRepoImpl({required localDataSrc, required remoteDataSrc})
      : _localDataSrc = localDataSrc,
        _remoteDataSrc = remoteDataSrc;

  @override
  Future<Either<Failure, List<Employer>>> loadFromApi() async {
    try {
      final result = await _remoteDataSrc.loadEmployers();
      return Right(result);
    } on ApiException catch (exception) {
      return Left(ApiFailure.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, List<Employer>>> loadFromDataBase() async {
    final result = await _localDataSrc.loadEmployersDb();
    return Right(result);
  }

  @override
  Future<Either<Failure, void>> updateData(List<Employer> employers) async {
    await _localDataSrc.updateEmployersDb(employers);
    return const Right(null);
  }
}
