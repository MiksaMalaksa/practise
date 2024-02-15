import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final String message;
  final dynamic statusCode;

  const ApiException({required this.message, required this.statusCode});

  @override
  List<dynamic> get props => [message, statusCode];
}
