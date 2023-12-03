import 'package:flutter/material.dart';
import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/pages/reset_password_page.dart';
import 'package:kelime_oyunu/pages/home_page.dart';
import 'package:kelime_oyunu/pages/login_page.dart';
import 'package:kelime_oyunu/pages/profile_page.dart';
import 'package:kelime_oyunu/pages/register_page.dart';
import 'package:kelime_oyunu/route_generator.dart';
import 'package:kelime_oyunu/viewmodels/single_game_model.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SingleViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.rotaOlustur,
      debugShowCheckedModeBanner: false,
      title: 'Word Wars',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
