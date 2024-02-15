import 'package:hive_flutter/hive_flutter.dart';
import 'package:testik/source/data/data_sources/local_data_source/i_local_data_source.dart';
import 'package:testik/source/data/models/employer_model.dart';
import 'package:testik/source/domain/entities/employer.dart';


class LocalDataSource implements ILocalDataSource {
  final Box box;
  LocalDataSource({required this.box});

  @override
  Future<List<Employer>> loadEmployersDb() async {
    return (box.values.toList())
        .map((source) => EmployerModel.fromJson(source: source))
        .toList();
  }

  @override
  Future<void> updateEmployersDb(List<Employer> employers) async {
    box.clear();
    final employersModels =
        employers.map((e) => EmployerModel.fromEntity(employer: e)).toList();
    for (var model in employersModels) {
      box.put(model.id, model.toJson());
    }
  }
}
