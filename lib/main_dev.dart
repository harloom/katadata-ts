import 'package:flutter/material.dart';
import 'package:ilham_kata_data_test/module/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ilham_kata_data_test/module/shareds/register.dart';

void main() async {
  await dotenv.load(fileName: ".env.dev");
  final baseURL = dotenv.get('BASE_URL');
  final appEnv = dotenv.get('APP');
  print('BASE URL : $baseURL - $appEnv');

  /// inject registerSingleton
  registerSingleton(baseURL);

  runApp( MyApp(
    appEnv: appEnv,
  ));
}
