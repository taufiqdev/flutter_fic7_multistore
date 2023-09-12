import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variable.dart';
import '../models/categories_response_model.dart';
import 'auth_local_datasource.dart';

class CategoriesRemoteDatasource {
  Future<Either<String, CategoriesResponseModel>> getCategories() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/categories'),
        headers: headers);

    if (response.statusCode == 200) {
      return Right(CategoriesResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error, please contact admin');
    }
  }
}
