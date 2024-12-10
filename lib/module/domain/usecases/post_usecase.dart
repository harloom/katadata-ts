
import 'package:ilham_kata_data_test/module/data/models/post_response_model.dart';
import 'package:ilham_kata_data_test/module/domain/repositories/post_repository.dart';

abstract class PostUseCase{
  Future<PostResponse> getPost({int? start, int? limit});
  Future<PostResponse> searchPost({required RegExp regExp});
}

class PostUseCaseImpl extends PostUseCase{
  final PostRepository postRepository;

  PostUseCaseImpl({required this.postRepository});
  @override
  Future<PostResponse> getPost({int? start, int? limit}) {
    return postRepository.getPost(start: start,limit: limit);
  }

  @override
  Future<PostResponse> searchPost({required RegExp regExp}) {
    return postRepository.searchPost(regExp: regExp);
  }

}