import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:katalog/data/dataSource/auth_local_datasource.dart';
import 'package:katalog/data/models/response/product_response_model.dart';
import 'package:katalog/variables.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    try {
      final isAuth = await AuthLocalDataSource().isAuth();
      if (!isAuth) {
        return left('User not authenticated');
      }

      final authData = await AuthLocalDataSource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/products'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        return right(ProductResponseModel.fromJson(response.body));
      } else {
        return left(response.body);
      }
    } catch (e) {
      print('Error retrieving products: $e');
      return left('Failed to retrieve products');
    }
  }
}
