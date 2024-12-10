import 'package:ilham_kata_data_test/module/data/models/news_model.dart';

class PostResponse {
  final String message;
  final int? statusCode;
  final bool? isError;
  final List<PostModel>? post;

  PostResponse(
      {this.message = 'Not Found', this.statusCode = 404, this.post, this.isError = false});
}
