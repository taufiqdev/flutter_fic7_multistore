import 'package:dartz/dartz.dart';
import 'package:flutter_fic7_multistore/data/models/order_response_model.dart';
import 'package:flutter_fic7_multistore/data/models/request/order_request_model.dart';
import 'package:http/http.dart' as http;
import '../../common/global_variable.dart';
import 'auth_local_datasource.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel orderRequestModel) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/logout'),
        headers: headers,
        body: orderRequestModel.toMap());
    if (response.statusCode == 200) {
      return Right('Logout Success');
    } else {
      return const Left('Server Error');
    }
  }
}
