import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/pages/home_page.dart';
import 'package:kelime_oyunu/pages/top_ten_page.dart';
import 'package:kelime_oyunu/route_generator.dart';
import 'package:kelime_oyunu/viewmodels/single_game_model.dart';
import 'package:kelime_oyunu/viewmodels/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox('user');
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SingleViewModel()),
    ChangeNotifierProvider(create: (_) => UserViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel _userModel =
        Provider.of<UserViewModel>(context, listen: true);
    _userModel.beniHatirlaKontrol();
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
