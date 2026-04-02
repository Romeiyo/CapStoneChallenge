import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geo_weather_logger_app/data/auth_service.dart';
import 'package:geo_weather_logger_app/data/location_service.dart';
import 'package:geo_weather_logger_app/data/settings_repository.dart';
import 'package:geo_weather_logger_app/data/weather_repository.dart';
import 'package:geo_weather_logger_app/domain/auth_provider.dart';
import 'package:geo_weather_logger_app/domain/settings_provider.dart';
import 'package:geo_weather_logger_app/domain/weather_provider.dart';
import 'package:geo_weather_logger_app/firebase_options.dart';
import 'package:geo_weather_logger_app/presentation/screens/auth_gate.dart';
import 'package:geo_weather_logger_app/routes/app_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(SettingsRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              WeatherProvider(WeatherRepository(), LocationService()),
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider(AuthService())),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'Weather Logger',
            navigatorKey: navigatorKey,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blueAccent,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: true,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}
