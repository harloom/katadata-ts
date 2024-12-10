import 'package:flutter/foundation.dart';
import 'package:ilham_kata_data_test/module/data/datasources/remote_data_sources.dart';
import 'package:ilham_kata_data_test/module/domain/repositories/post_repository.dart';
import 'package:ilham_kata_data_test/module/domain/usecases/post_usecase.dart';
import 'package:ilham_kata_data_test/module/shareds/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// GLOBAL
GetIt getIt = GetIt.instance;

/// IL [Inject registerSingleton]
void registerSingleton(String baseUrl){

  debugPrint('registerSingleton run..');

  getIt.registerSingleton<DioClient>(DioClient(dio: Dio(), baseUrl: baseUrl),
      signalsReady: true);
  getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl(dio:  getIt.get<DioClient>()),
      signalsReady: true);
  getIt.registerSingleton<PostRepository>(PostRepositoryImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
      signalsReady: true);
  getIt.registerSingleton<PostUseCase>(PostUseCaseImpl(postRepository: getIt.get<PostRepository>()),
      signalsReady: true);

  debugPrint('registerSingleton end..');
}
