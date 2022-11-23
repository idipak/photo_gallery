import 'package:dio/dio.dart';
import 'package:photo_search/network/custom_exception.dart';

class NetworkClient{

  NetworkClient();

  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.unsplash.com", connectTimeout: 10000, receiveTimeout: 6000,
  //     headers: {
  //   "Authorization": "Di_-PMrRMaLk6x00g6rnmkQGvbWi_8PYkDcYKN4TB_A"
  // }
  ),);


  Future<Response> getRequest(String path) async{
    try{
      return await _dio.get(path);
    }on DioError catch(e){
      throw CustomException.fromDioError(e);
    }
  }




}