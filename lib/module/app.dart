import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'presentation/page/home/home_page.dart';

class MyApp extends StatelessWidget {
  final String appEnv;
  const MyApp({super.key, required this.appEnv});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'KATADATA-ILHAM_TEST',
        debugShowCheckedModeBanner: appEnv == EnvDefault.dev,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class EnvDefault{
  static const String dev = 'DEV';
  static const String production = 'PRODUCTION';
}
