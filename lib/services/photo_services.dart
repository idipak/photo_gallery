
import 'package:photo_search/models/photo_response.dart';
import 'package:photo_search/network/http_client.dart';

class PhotoService{
  final httpClient = NetworkClient();

  Future<List<Result>> getPhotoByTag(String tag) async{
    try{
      final response = await httpClient.getRequest("/search/photos?query=$tag&client_id=Di_-PMrRMaLk6x00g6rnmkQGvbWi_8PYkDcYKN4TB_A");
      final data = PhotoResponse.fromJson(response.data);
      return data.results;
    } catch(e){
      rethrow;
    }
  }
}