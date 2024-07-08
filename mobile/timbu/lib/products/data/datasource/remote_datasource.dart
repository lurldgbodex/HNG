import 'package:dio/dio.dart';

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
      const urlPath =
          "https://api.timbu.cloud/products?organization_id=9d03c938e268430faf6888cfe94b157f&reverse_sort=false&page=1&size=10&Appid=YTACWZ0CD39JXRZ&Apikey=30efb4c0d0624be49528357333af305a20240705110431137026";

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
      throw ServerException(ex.toString());
    }
  }
}
