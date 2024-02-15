import 'package:equatable/equatable.dart';
import 'package:testik/core/errors/exeptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;

  const Failure({required this.message, required this.statusCode});

  String get errorMessage =>
      "$statusCode ${statusCode is String ? '' : "Error"}: $message";

  @override
  List<dynamic> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  factory ApiFailure.fromException(ApiException exception) =>
      ApiFailure(message: exception.message, statusCode: exception.statusCode);
}
