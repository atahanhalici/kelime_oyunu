import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/pages/forget_password_page.dart';
import 'package:kelime_oyunu/pages/home_page.dart';
import 'package:kelime_oyunu/pages/login_page.dart';
import 'package:kelime_oyunu/pages/profile_page.dart';
import 'package:kelime_oyunu/pages/register_page.dart';
import 'package:kelime_oyunu/pages/reset_password_page.dart';
import 'package:kelime_oyunu/pages/single_game_page.dart';
import 'package:kelime_oyunu/pages/top_ten_page.dart';

class RouteGenerator {
  static Route<dynamic>? _gidilecekrota(
      Widget gidilecekWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          settings: settings, builder: (context) => gidilecekWidget);
    } else {
      return MaterialPageRoute(
          settings: settings, builder: (context) => gidilecekWidget);
    }
  }

  static Route<dynamic>? rotaOlustur(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _gidilecekrota(const HomePage(), settings);
      case '/homepage':
        return _gidilecekrota(const HomePage(), settings);
      case '/login':
        return _gidilecekrota(const LoginPage(), settings);
      case '/register':
        return _gidilecekrota(const RegisterPage(), settings);
      case '/singlegame':
        return _gidilecekrota(const SingleGamePage(), settings);
      case '/forgetpassword':
        return _gidilecekrota(const ForgetPasswordPage(), settings);
      case '/profilepage':
        return _gidilecekrota(const ProfilPage(), settings);
      case '/resetpassword':
        return _gidilecekrota(const ResetPasswordPage(), settings);
      case '/toptenpage':
        return _gidilecekrota(const TopTenPage(), settings);
      default:
        return _gidilecekrota(const HomePage(), settings);
    }
  }
}
