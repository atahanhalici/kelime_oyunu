import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelime_oyunu/pages/single_game_page.dart';
import 'package:kelime_oyunu/viewmodels/single_game_model.dart';
import 'package:kelime_oyunu/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SingleViewModel _singleModel =
        Provider.of<SingleViewModel>(context, listen: true);
    UserViewModel _userModel =
        Provider.of<UserViewModel>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return _userModel.state == ViewStates.geldi
        ? _userModel.user.id != ""
            ? SafeArea(
                child: Scaffold(
                  body: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple,
                              Colors.purpleAccent,
                              Colors.deepPurpleAccent,
                              Colors.deepPurple
                            ],
                          )),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.width / 2 - 100,
                                child: Visibility(
                                  visible: _userModel.user.id.length == 24,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.groups,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                        const Expanded(child: SizedBox()),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/profilepage");
                                            },
                                            child: CircleAvatar(
                                                radius: 17,
                                                backgroundImage: _userModel
                                                            .user.avatar ==
                                                        "default.jpg"
                                                    ? const AssetImage(
                                                        "assets/default.jpg")
                                                    : MemoryImage(base64Decode(
                                                            _userModel
                                                                .user.avatar))
                                                        as ImageProvider)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Image.asset("assets/logo.png"),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Kelimelerle Savaş, Kazanan Sen Ol!",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Outfit",
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 90,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 238, 238, 238),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Oyuna Başla!",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Outfit",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        _singleModel.singleKelimeGetir(_userModel.user.sonsoru);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SingleGamePage()));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          "Tek Oyunculu",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      onPressed: () {},
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 94, 94, 94),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          "Çok Oyunculu (Yakında)",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  body: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple,
                              Colors.purpleAccent,
                              Colors.deepPurpleAccent,
                              Colors.deepPurple
                            ],
                          )),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.width / 2 - 100,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Image.asset("assets/logo.png"),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Kelimelerle Savaş, Kazanan Sen Ol!",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Outfit",
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 90,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 238, 238, 238),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Aramıza Hoşgeldin",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Outfit",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/login");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          "Oturum Aç",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        await _userModel.misafirGiris();
                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "/homepage",
                                            (route) => false);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 94, 94, 94),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          "Misafir Oyuncu",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
        : Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple,
                Colors.purpleAccent,
                Colors.deepPurpleAccent,
                Colors.deepPurple
              ],
            )),
            child: Center(child: Image.asset("assets/logo.png")),
          );
  }
}
