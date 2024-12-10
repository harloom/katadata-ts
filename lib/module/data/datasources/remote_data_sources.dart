
import 'package:ilham_kata_data_test/module/data/models/news_model.dart';
import 'package:ilham_kata_data_test/module/data/models/post_response_model.dart';
import 'package:ilham_kata_data_test/module/shareds/dio_client.dart';
import 'package:ilham_kata_data_test/module/shareds/exception.dart';

abstract class RemoteDataSource {
  Future<PostResponse> getPost({int? start, int? limit});
  Future<PostResponse> searchPost({required RegExp regExp});
}

class RemoteDataSourceImpl  extends RemoteDataSource{
  final DioClient dio;

  RemoteDataSourceImpl({required this.dio});
  @override
  Future<PostResponse> getPost({int? start, int? limit}) async{
    try{
      var res = await dio.get('/posts?_start=$start&_limit=$limit');
      // print('rawResponse : ${res.statusCode} == ${res.data}');

      var jsonList = res.data as List<dynamic>;
      return PostResponse(
          post: jsonList.map((e) => PostModel.fromJson(e)).toList(),
          message: 'OK',
          statusCode: 200
      );
    }catch(e){
      if(e is ServerException){
        return PostResponse(message: e.errorMessage, statusCode: e.statusCode,isError:  true );
      }
      return PostResponse(message: '$e' ,isError:  true);
    }

  }

  @override
  Future<PostResponse> searchPost({required RegExp regExp})  async{
    try{
      var res = await dio.get('/posts?title_like=${regExp.pattern}');

      var jsonList = res.data as List<dynamic>;
      return PostResponse(
          post: jsonList.map((e) => PostModel.fromJson(e)).toList(),
          message: 'OK',
          statusCode: 200
      );
    }catch(e){
      if(e is ServerException){
        return PostResponse(message: e.errorMessage, statusCode: e.statusCode ,isError:  true);
      }
      return PostResponse(message: '$e' ,isError:  true);
    }
  }

}