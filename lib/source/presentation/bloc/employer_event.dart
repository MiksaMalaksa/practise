part of 'employer_bloc.dart';

sealed class EmployerEvent extends Equatable {
  const EmployerEvent();

  @override
  List<Object> get props => [];
}

final class LoadEmployersBd extends EmployerEvent {
  const LoadEmployersBd();
}

final class LoadEmployersApi extends EmployerEvent {
  const LoadEmployersApi();
}

final class UpdateEmployers extends EmployerEvent {
  final List<Employer> employers;
  
  const UpdateEmployers({required this.employers});

  @override
  List<Object> get props => employers.map((employer) => employer.id).toList();
}
