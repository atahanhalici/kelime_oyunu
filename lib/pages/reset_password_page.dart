import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kelime_oyunu/viewmodels/single_game_model.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ResetPasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SingleViewModel _singleModel =
        Provider.of<SingleViewModel>(context, listen: true);

    Size size = MediaQuery.of(context).size;
    FocusScopeNode currentFocus = FocusScopeNode();
    return Listener(
      onPointerDown: (_) {
        currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
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
                  Image.asset("assets/logo.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 238, 238),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Şifre Değiştir",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Outfit",
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          height: 70,
                          decoration: BoxDecoration(
                            //color: Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: "Outfit",
                            ),
                            //  controller: _titleController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Colors.black,
                            maxLines: 1,

                            decoration: const InputDecoration(
                              labelText: "Mevcut Şifre",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "Outfit",
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(),
                            ),
                            validator: (deger) {
                              if (deger!.length < 4) {
                                _oldPasswordController.text = "";
                                return "Şifreniz en az 4 karakter uzunluğunda olmalıdır!";
                              } else if (deger.length > 20) {
                                _oldPasswordController.text = "";
                                return "Şifreniz en çok 20 karakter uzunluğunda olmalıdır!";
                              } else {
                                _oldPasswordController.text = deger;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          height: 70,
                          decoration: BoxDecoration(
                            //color: Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: "Outfit",
                            ),
                            //  controller: _titleController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Colors.black,

                            maxLines: 1,
                            decoration: const InputDecoration(
                              labelText: "Yeni Şifre",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "Outfit",
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(),
                            ),
                            validator: (deger) {
                              if (deger!.length < 4) {
                                _newPasswordController.text = "";
                                return "Şifreniz en az 4 karakter uzunluğunda olmalıdır!";
                              } else if (deger.length > 20) {
                                _newPasswordController.text = "";
                                return "Şifreniz en çok 20 karakter uzunluğunda olmalıdır!";
                              } else {
                                _newPasswordController.text = deger;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          height: 70,
                          decoration: BoxDecoration(
                            //color: Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: "Outfit",
                            ),
                            //  controller: _titleController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Colors.black,

                            maxLines: 1,
                            decoration: const InputDecoration(
                              labelText: "Yeni Şifre",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "Outfit",
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(),
                            ),
                            validator: (deger) {
                              if (deger!.length < 4) {
                                _newPasswordController2.text = "";
                                return "Şifreniz en az 4 karakter uzunluğunda olmalıdır!";
                              } else if (deger.length > 20) {
                                _newPasswordController2.text = "";
                                return "Şifreniz en çok 20 karakter uzunluğunda olmalıdır!";
                              } else {
                                _newPasswordController2.text = deger;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Şifre Değiştir",
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}