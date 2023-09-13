import 'package:dartz/dartz.dart';
import 'package:flutter_fic7_multistore/data/models/products_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variable.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getProducts() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/products'),
        headers: headers);

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error, please contact admin');
    }
  }

  Future<Either<String, ProductsResponseModel>> getProductsByCategory(
      int catagory_id) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.get(
        Uri.parse(
            '${GlobalVariables.baseUrl}/api/products?catagory_id=${catagory_id}'),
        headers: headers);

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error, please contact admin');
    }
  }
}
