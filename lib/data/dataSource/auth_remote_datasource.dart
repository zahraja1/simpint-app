import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:katalog/data/dataSource/auth_local_datasource.dart';
import 'package:katalog/data/models/response/auth_response_models.dart';
import 'package:katalog/variables.dart';

class AuthRemoteDataSource{
  Future<Either<String, AuthResponseModel>> login(
    String email, 
    String password,
  ) async {
    final response = await http.post(
      // postman versi code
      Uri.parse('${Variables.baseUrl}/api/login'),
      
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(json.decode(response.body)));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );
    if (response.statusCode == 200) {
      return right(response.body);
    } else {
      return left(response.body);
    }
  }
}