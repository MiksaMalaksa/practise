import 'package:testik/source/domain/entities/employer.dart';

abstract class ILocalDataSource {
  Future<List<Employer>> loadEmployersDb();
  Future<void> updateEmployersDb(List<Employer> employers);
}
