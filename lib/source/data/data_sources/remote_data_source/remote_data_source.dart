import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testik/core/constants/mock_api.dart';
import 'package:testik/core/errors/exeptions.dart';
import 'package:testik/source/data/models/employer_model.dart';
import 'package:testik/source/domain/entities/employer.dart';

abstract class RemoteDataSource {
  Future<List<Employer>> loadEmployers();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client _client;
  RemoteDataSourceImpl({required http.Client client}) : _client = client;

  @override
  Future<List<EmployerModel>> loadEmployers() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kEndPoint));
      if (response.statusCode > 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List)
          .map((employer) => EmployerModel.fromMap(map: employer))
          .toList();
    } on ApiException {
      rethrow;
    } catch (exception) {
      throw ApiException(message: exception.toString(), statusCode: 505);
    }
  }
}
