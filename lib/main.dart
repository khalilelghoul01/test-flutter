import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/blocs/images/images_bloc.dart';
import 'package:test/repositories/images_api_repository.dart';
import 'package:test/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagesBloc(api: ImagesApiRepository()),
      child: MaterialApp(
        title: 'Test Technique',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: AppRoutes.search,
        onGenerateInitialRoutes: RouteGenerator.initialRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
