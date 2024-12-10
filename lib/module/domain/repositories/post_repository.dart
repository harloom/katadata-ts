
import 'package:ilham_kata_data_test/module/data/datasources/remote_data_sources.dart';
import 'package:ilham_kata_data_test/module/data/models/post_response_model.dart';

abstract class PostRepository{
  Future<PostResponse> getPost({int? start, int? limit});
  Future<PostResponse> searchPost({required RegExp regExp});
}

class PostRepositoryImpl extends PostRepository{
  final RemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PostResponse> getPost({int? start, int? limit}) {
    return remoteDataSource.getPost(start: start,limit: limit);
  }

  @override
  Future<PostResponse> searchPost({required RegExp regExp}) {
    return remoteDataSource.searchPost(regExp: regExp);
  }
}

