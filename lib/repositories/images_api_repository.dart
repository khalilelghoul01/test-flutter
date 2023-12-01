import 'package:dio/dio.dart';
import 'package:test/constants/env.dart';
import 'package:test/model/pixabay_response_model.dart';

class ImagesApiRepository {
  final Dio _dio = Dio();

  Future<PixabayResponse> fetchImages(
    String query,
    int page, [
    int perPage = 20,
  ]) async {
    String url =
        '${ENV.baseUrl}&q=$query&per_page=30&page=$page&per_page=$perPage';
    final response = await _dio.get(url);
    return PixabayResponse.fromJson(response.data);
  }
}
