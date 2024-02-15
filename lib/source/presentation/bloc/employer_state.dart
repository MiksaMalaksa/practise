part of 'employer_bloc.dart';

sealed class EmployerState extends Equatable {
  const EmployerState();

  @override
  List<Object> get props => [];
}

final class EmployerInitial extends EmployerState {
  const EmployerInitial();
}

final class LoadingEmployers extends EmployerState {
  const LoadingEmployers();
}

final class LoadedEmployers extends EmployerState {
  final List<Employer> employers;

  const LoadedEmployers({required this.employers});

  @override
  List<Object> get props => employers.map((employer) => employer.id).toList();
}

final class UpdatedEmployers extends EmployerState {
  const UpdatedEmployers();
}

final class LoadingError extends EmployerState {
  final String failureMessage;
  final String failureStatus;

  const LoadingError(
      {required this.failureMessage, required this.failureStatus});

  @override
  List<String> get props => [failureMessage, failureStatus];
}