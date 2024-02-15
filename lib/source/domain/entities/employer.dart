import 'package:equatable/equatable.dart';

class Employer extends Equatable {
  final String fullName;
  final String avatar;
  final String jobTitle;
  final String id;

  const Employer(
      {required this.fullName,
      required this.avatar,
      required this.jobTitle,
      required this.id});

  @override
  List<Object?> get props => [id];
}
