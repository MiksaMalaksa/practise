import 'dart:convert';
import 'package:testik/source/domain/entities/employer.dart';


class EmployerModel extends Employer {
  const EmployerModel(
      {required super.fullName,
      required super.avatar,
      required super.jobTitle,
      required super.id});

  EmployerModel.fromMap({required Map<String, dynamic> map})
      : this(
            avatar: map['avatar'] as String,
            fullName: map['name'] as String,
            jobTitle: map['work'] as String,
            id: map['id'] as String);

  Map<String, dynamic> toMap() =>
      {'id': id, 'work': jobTitle, 'fullName': fullName, 'avatar': avatar};

  String fromMap() => jsonEncode(toMap());

  String toJson() => json.encode(toMap());

  factory EmployerModel.fromEntity({required Employer employer}) =>
      EmployerModel(
          fullName: employer.fullName,
          avatar: employer.avatar,
          jobTitle: employer.jobTitle,
          id: employer.id);

  factory EmployerModel.fromJson({required String source}) =>
      EmployerModel.fromMap(map: jsonDecode(source) as Map<String, dynamic>);
}
