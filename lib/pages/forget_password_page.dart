import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();
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
                    Image.asset("assets/logo.png"),
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
                            "Şifremi Unuttum",
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
                                labelText: "E-Mail",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Outfit",
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
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
                            height: 25,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              if (_emailController.text != "") {
                                var sonuc = await _userModel
                                    .sifremiUnuttum(_emailController.text);

                                if (sonuc["code"] == 200) {
                                  Navigator.pop(context);
                                  alertDialog("Başarılı", sonuc["response"]);
                                } else {
                                  alertDialog("Hata", sonuc["response"]);
                                }
                              } else {
                                kShowSnackBar(
                                    context, "Tüm Değerler Dolu Görünmüyor");
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Bağlantı Gönder",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Outfit",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Şifreni Hatırlıyor musun?",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Outfit",
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Giriş Yap!",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Outfit",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
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
    );
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
