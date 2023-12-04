import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelime_oyunu/viewmodels/user_model.dart';
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
  void initState() {
    _userNameController.text =
        Provider.of<UserViewModel>(context, listen: false).user.kullaniciadi;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel _userModel =
        Provider.of<UserViewModel>(context, listen: true);
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
                              ? _userModel.user.avatar == "default.jpg"
                                  ? const AssetImage("assets/default.jpg")
                                  : MemoryImage(
                                          base64Decode(_userModel.user.avatar))
                                      as ImageProvider
                              : FileImage(_profilphoto!),
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
                            controller: _userNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: Colors.black,
                            maxLines: 1,
                            //initialValue: _userModel.user.kullaniciadi,
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
                            initialValue: _userModel.user.email,
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
                          onPressed: () async {
                            String? base64 = "";
                            if (_profilphoto != null) {
                              base64 = await _getImageBase64(_profilphoto!);
                            }
                            print(_userNameController);
                            if (_userNameController.text != "" ||
                                _userNameController.text ==
                                    _userModel.user.kullaniciadi) {
                              Map veriler = {
                                "kullaniciadi": _userNameController.text,
                                "avatar": base64 ?? "",
                                "id": _userModel.user.id
                              };
                              var sonuc = await _userModel.guncelle(veriler);
                              if (sonuc["code"] == 200) {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/homepage", (route) => false);
                                alertDialog("Başarılı", sonuc["response"]);
                              } else {
                                alertDialog("Hata", sonuc["response"]);
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              kShowSnackBar(
                                  context, "Tüm Değerler Dolu Görünmüyor");
                            }
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
    if (photo != null) {
      photofile = File(photo.path);
    }
    Navigator.of(context).pop();
    setState(() {
      if (photofile != null) _profilphoto = photofile;
    });
  }

  void _galeridenFotoSec() async {
    File? imagefile;
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagefile = File(image.path);
    }
    Navigator.of(context).pop();
    setState(() {
      if (imagefile != null) _profilphoto = imagefile;
    });
  }

  Future<String?> _getImageBase64(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  void kShowSnackBar(BuildContext context, String message) {
    if (kDebugMode) print(message);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  alertDialog(String baslik, String icerik) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            baslik,
            style: const TextStyle(
              fontFamily: "Outfit",
              color: Colors.black,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  icerik,
                  style: const TextStyle(
                    fontFamily: "Outfit",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Tamam",
                style: TextStyle(
                  fontFamily: "Outfit",
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
