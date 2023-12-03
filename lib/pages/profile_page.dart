import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelime_oyunu/viewmodels/single_game_model.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _profilphoto;
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
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 115,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading:
                                        const Icon(Icons.camera_alt_rounded),
                                    title: const Text("Kameradan Çek"),
                                    onTap: () {
                                      _kameradanFotoCek();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text("Galeriden Seç"),
                                    onTap: () {
                                      _galeridenFotoSec();
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _profilphoto == null
                              ? const AssetImage("assets/pp.jpg")
                              : FileImage(_profilphoto!) as ImageProvider,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 51, 107, 252),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.create,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
                          "Profil",
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
                            initialValue: "username",
                            decoration: const InputDecoration(
                              labelText: "Kullanıcı Adı",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "Outfit",
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person),
                            ),
                            validator: (deger) {
                              if (deger!.isEmpty) {
                                _userNameController.text = "";
                                return "Kullanıcı Adı Kısmı Boş Bırakılamaz!";
                              } else {
                                _userNameController.text = deger;
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
                            readOnly: true,
                            initialValue: "wordwarsgame@gmail.com",
                            maxLines: 1,
                            decoration: const InputDecoration(
                              labelText: "E-Mail",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "Outfit",
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.alternate_email),
                            ),
                            validator: (deger) {
                              if (deger!.isEmpty) {
                                _emailController.text = "";
                                return "E-Mail Kısmı Boş Bırakılamaz!";
                              } else if (!deger.contains("@") ||
                                  !deger.contains(".")) {
                                _emailController.text = "";
                                return "Geçersiz Mail Formatı. Lütfen Kontrol Ediniz";
                              } else {
                                _emailController.text = deger;
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
                              "Değişiklikleri Kaydet",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Outfit",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/resetpassword");
                          },
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
                        Image.asset(
                          "assets/logo_black.png",
                          width: size.width / 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _kameradanFotoCek() async {
    File? photofile;
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) photofile = File(photo.path);
    Navigator.of(context).pop();
    setState(() {
      if (photofile != null) _profilphoto = photofile;
    });
  }

  void _galeridenFotoSec() async {
    File? imagefile;
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) imagefile = File(image.path);
    Navigator.of(context).pop();
    setState(() {
      if (imagefile != null) _profilphoto = imagefile;
    });
  }
}
