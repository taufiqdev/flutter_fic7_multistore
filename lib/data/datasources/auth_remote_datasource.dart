//import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:flutter_fic7_multistore/common/global_variable.dart';
import '../models/auth_response_model.dart';
import '../models/request/login_request_model.dart';
import '../models/request/register_request_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    //final response = await http.post('${GlobalVariables.baseUrl}/api/register')
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/register'),
        headers: headers,
        body: model.toJson());
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    //final response = await http.post('${GlobalVariables.baseUrl}/api/register')
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/login'),
        headers: headers,
        body: model.toJson());
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, String>> logout() async {
    //final response = await http.post('${GlobalVariables.baseUrl}/api/register')
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/logout'),
        headers: headers);
    if (response.statusCode == 200) {
      return Right('Logout Success');
    } else {
      return const Left('Server Error');
    }
  }
}
