import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../error/server_exception.dart';
import '../model/product_model.dart';

abstract interface class RemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final Dio dioClient;

  RemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      final appId = dotenv.env['APP_ID'];
      final apiKey = dotenv.env['API_KEY'];
      final orgId = dotenv.env['ORG_ID'];

      final urlPath =
          "$baseUrl/products?organization_id=$orgId&reverse_sort=false&page=1&size=10&Appid=$appId&Apikey=$apiKey";

      final response = await dioClient.get(urlPath);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final items = data['items'] as List<dynamic>;

        return items.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw const ServerException("Failed to load products");
      }
    } on DioException catch (de) {
      throw ServerException(de.message ?? "Unkwon error");
    } catch (ex) {
      throw const ServerException("Something went wrong");
    }
  }
}
