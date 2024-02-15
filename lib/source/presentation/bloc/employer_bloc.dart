import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:testik/core/usecases/usecase.dart';
import 'package:testik/source/domain/entities/employer.dart';
import 'package:testik/source/domain/usecases/load_employers_api.dart';
import 'package:testik/source/domain/usecases/load_employers_db.dart';
import 'package:testik/source/domain/usecases/update_employers_db.dart';

part 'employer_event.dart';
part 'employer_state.dart';

class EmployerBloc extends Bloc<EmployerEvent, EmployerState> {
  final LoadFromApi _loadFromApi;
  final LoadFromDb _loadFromDb;
  final UpdateToDb _updateEmployers;

  EmployerBloc(
      {required LoadFromApi loadFromApi,
      required LoadFromDb loadFromDb,
      required UpdateToDb updateEmployers})
      : _loadFromApi = loadFromApi,
        _loadFromDb = loadFromDb,
        _updateEmployers = updateEmployers,
        super(const EmployerInitial()) {
    on<LoadEmployersApi>(_onLoadApi);
    on<LoadEmployersBd>(_onLoadDb);
    on<UpdateEmployers>(_onUpdateDb);
  }

  Future<void> _onLoadApi(
      LoadEmployersApi event, Emitter<EmployerState> emit) async {
    emit(const LoadingEmployers());

    final result = await _loadFromApi(NoParams());
    result.fold(
      (failure) => emit(LoadingError(
          failureMessage: failure.message,
          failureStatus: failure.statusCode)), 
      (employers) => emit(LoadedEmployers(
          employers: employers)), 
    );
  }

  Future<void> _onLoadDb(
      LoadEmployersBd event, Emitter<EmployerState> emit) async {
    emit(const LoadingEmployers());

    final result = await _loadFromDb(NoParams());
    result.fold(
        (failure) => emit(LoadingError(
            failureMessage: failure.message,
            failureStatus: failure.statusCode)),
        (employers) => LoadedEmployers(employers: employers));
  }

  Future<void> _onUpdateDb(
      UpdateEmployers event, Emitter<EmployerState> emit) async {
    emit(const LoadingEmployers());

    await _updateEmployers(event.employers);
    emit(const UpdatedEmployers());
  }
}
