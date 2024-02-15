import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:http/http.dart' as http;
import 'package:testik/source/data/data_sources/local_data_source/i_local_data_source.dart';
import 'package:testik/source/data/data_sources/local_data_source/local_data_source.dart';
import 'package:testik/source/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:testik/source/data/repositories/employer_repo_impl.dart';
import 'package:testik/source/domain/repositories/employer_repo.dart';
import 'package:testik/source/domain/usecases/load_employers_api.dart';
import 'package:testik/source/domain/usecases/load_employers_db.dart';
import 'package:testik/source/domain/usecases/update_employers_db.dart';
import 'package:testik/source/presentation/bloc/employer_bloc.dart';

var sl = GetIt.instance;
const boxKey = 'employers';

Future<void> init() async {
  //*Hive initialising
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  final box = await Hive.openBox(boxKey);
  sl.registerSingleton<Box>(box);

  //*data sources
  sl.registerLazySingleton(http.Client.new);
  sl.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl(client: sl()));
  sl.registerSingleton<ILocalDataSource>(LocalDataSource(box: sl()));

  //*repo's
  sl.registerSingleton<EmployerRepo>(
    EmployerRepoImpl(
      remoteDataSrc: sl<RemoteDataSource>(),
      localDataSrc: sl<ILocalDataSource>(),
    ),
  );

  //*usecases
  sl.registerSingleton<LoadFromApi>(LoadFromApi(repo: sl()));
  sl.registerSingleton<LoadFromDb>(LoadFromDb(repo: sl()));
  sl.registerSingleton<UpdateToDb>(UpdateToDb(repo: sl()));

  //*app logic
  sl.registerFactory<EmployerBloc>(() =>
      EmployerBloc(loadFromApi: sl(), loadFromDb: sl(), updateEmployers: sl()));
}
