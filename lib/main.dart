import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/futurama_datasource.dart';
import 'data/repositories/character_repository.dart';
import 'domain/usecases/get_data_usecase.dart';
import 'presentation/viewmodels/character_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() {
  final datasource = FuturamaDataSource();
  final repository = CharactersRepository(datasource);
  final useCase = GetDataUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterViewModel(useCase)..loadData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
            secondary: Colors.deepOrangeAccent,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        initialRoute: "/",
        routes: AppRoutes.routes,
      ),
    ),
  );
}
