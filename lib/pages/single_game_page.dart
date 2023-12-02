import 'package:flutter/material.dart';
import 'package:kelime_oyunu/viewmodels/single_game_model.dart';
import 'package:provider/provider.dart';

class SingleGamePage extends StatefulWidget {
  const SingleGamePage({Key? key}) : super(key: key);

  @override
  State<SingleGamePage> createState() => _SingleGamePageState();
}

class _SingleGamePageState extends State<SingleGamePage> {
  //Map<int, String> tahmin = {};
  TextEditingController _controller = TextEditingController();
  //List aciklar = [4];
  int sayac = 1;

  @override
  void initState() {
    _controller.text = "a";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SingleViewModel _singleModel =
        Provider.of<SingleViewModel>(context, listen: true);

    FocusNode focusNode = FocusNode();
    //String kelime = "word wars";
    /* Map ipucu = {
      0: "w",
      1: "o",
      2: "r",
      3: "d",
      4: " ",
      5: "w",
      6: "a",
      7: "r",
      8: "s"
    };*/

    int toplamPuan = 1500,
        sPuan =
            ((_singleModel.ipucu.length - _singleModel.aciklar.length)) * 100;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
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
                  _singleModel.state == ViewState.geldi
                      ? _singleModel.kelimeler[0].id != ""
                          ? _singleModel.bitti == false
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Toplam Puan\n$toplamPuan",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 238, 238, 238),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20))),
                                          child: Image.asset(
                                            "assets/logo_black.png",
                                            width: 150,
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        Text(
                                          "Soru Puanı\n$sPuan",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    Opacity(
                                      opacity: 0,
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: _controller,
                                        autofocus: true,
                                        focusNode: focusNode,
                                        onChanged: (value) {
                                          if (_singleModel.tahmin.length +
                                                  _singleModel.aciklar.length !=
                                              _singleModel.ipucu.length) {
                                            _singleModel.renkSifirla();
                                          }
                                          var yeniCumle = value.split("");

                                          if (_controller.text != "") {
                                            for (int i = 0;
                                                i < _singleModel.aciklar.length;
                                                i++) {
                                              _singleModel.tahmin[
                                                      _singleModel.aciklar[i]] =
                                                  _singleModel.ipucu.values
                                                          .toList()[
                                                      _singleModel.aciklar[i]];
                                            }
                                            for (int i = -1;
                                                i <
                                                    _singleModel.ipucu.length -
                                                        1;
                                                i++) {
                                              if (_singleModel.tahmin
                                                  .containsKey(i + 1)) {
                                              } else {
                                                if (yeniCumle[0] == "a") {
                                                  _singleModel.tahmin[i + 1] =
                                                      yeniCumle[1];
                                                } else {
                                                  _singleModel.tahmin[i + 1] =
                                                      yeniCumle[0];
                                                }

                                                break;
                                              }
                                            }
                                          } else {
                                            _singleModel.aciklar
                                                .forEach((index) {
                                              _singleModel.tahmin.remove(index);
                                            });
                                            int? maxKey;

                                            if (_singleModel
                                                .tahmin.isNotEmpty) {
                                              maxKey = _singleModel.tahmin.keys
                                                  .reduce(
                                                      (a, b) => a > b ? a : b);
                                            }

                                            _singleModel.tahmin.remove(maxKey);

                                            /* _singleModel.tahmin
                                  .remove(_singleModel.tahmin.length - 1);*/
                                            /* if (!_singleModel.aciklar
                                  .contains(_singleModel.tahmin.length - 1)) {
                                print("sa");
                                print(sayac);
                                _singleModel.tahmin
                                    .remove(_singleModel.tahmin.length - sayac);
                              } else {
                                print("saa");
                                _singleModel.tahmin.remove(
                                    _singleModel.tahmin.length - (sayac + 1));
                                sayac = 2;
                              }
                              if (_singleModel.tahmin.length ==
                                  _singleModel.aciklar.length) {
                                print("burdasım");
                                sayac = 1;
                              }
                              print(_singleModel.tahmin);
                              print(_singleModel.aciklar);*/
                                            /* for (int i = _singleModel.tahmin.length - 1;
                                  i >= 0;
                                  i--) {
                                print(i);

                                if (!_singleModel.aciklar.contains(i)) {
                                  _singleModel.tahmin.remove(i);
                                  print(_singleModel.tahmin);
                                  break;
                                } else {
                                  continue;
                                }
                              }*/
                                            /* for (int i = _singleModel.tahmin.length;
                                  i >= 0;
                                  i--) {
                                if (_singleModel.aciklar.contains(i)) {
                                } else {
                                  if (i == 3) {
                                    if (_singleModel.tahmin
                                        .containsKey(i - 1)) {
                                      _singleModel.tahmin.remove(i - 1);
                                    } else if (_singleModel.tahmin
                                        .containsKey(i - 2)) {
                                      _singleModel.tahmin.remove(i - 2);
                                    }
                                  } else if (i == 2) {
                                    _singleModel.tahmin.remove(i - 2);
                                  } else if (_singleModel.aciklar
                                      .contains(i - 1)) {
                                    _singleModel.tahmin.remove(i - 2);
                                  } else {
                                    _singleModel.tahmin.remove(i - 1);
                                  }
                                  print(_singleModel.tahmin);
                                  break;
                                }
                              }*/
                                          }
                                          if (value == "a") {
                                            // Metin boş ise focus'u geri al
                                            setState(() {});
                                            focusNode.unfocus();
                                            focusNode.requestFocus();
                                          }

                                          _controller.text = "a";
                                          setState(() {
                                            focusNode.unfocus();
                                            focusNode.requestFocus();
                                          });

                                          if (_singleModel.tahmin.length ==
                                              _singleModel.ipucu.length) {
                                            _singleModel.kontrol();
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 238, 238, 238),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            _singleModel.soru,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: "Outfit",
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        /*Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _singleModel.ipucu2.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 40,
                                    crossAxisCount: 1,
                                    crossAxisSpacing:
                                        8.0, // Yatayda öğeler arasındaki boşluk
                                    mainAxisSpacing:
                                        8.0, // Dikeyde öğeler arasındaki boşluk
                                  ),
                                  itemBuilder: (context, index) {
                                    return ListView.separated(
                                      itemCount: _singleModel.ipucu2.values
                                          .toList()[index]
                                          .length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, indexs) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              _singleModel.aciklar
                                                          .contains(indexs) !=
                                                      false
                                                  ? _singleModel
                                                      .ipucu2[index]!.values
                                                      .toList()[indexs]
                                                      .toString()
                                                      .toUpperCase()
                                                  : _singleModel
                                                              .tahmin[indexs] !=
                                                          null
                                                      ? _singleModel
                                                          .tahmin[indexs]
                                                          .toString()
                                                          .toUpperCase()
                                                      : " ",
                                              style: TextStyle(
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.bold,
                                                  color: _singleModel.renk,
                                                  fontSize: 25),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 25,
                                              color: _singleModel.renk,
                                            )
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ),*/
                                        GestureDetector(
                                          onTap: () {
                                            focusNode.requestFocus();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              color: Colors.transparent,
                                              width: size.width,
                                              height: 50,
                                              child: Center(
                                                child: ListView.separated(
                                                  itemCount:
                                                      _singleModel.ipucu.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      width:
                                                          (size.width - 150) /
                                                              (_singleModel
                                                                  .ipucu
                                                                  .length),
                                                      child: Opacity(
                                                        opacity: _singleModel
                                                                    .ipucu
                                                                    .values
                                                                    .toList()[
                                                                        index]
                                                                    .contains(
                                                                        " ") ==
                                                                true
                                                            ? 0
                                                            : 1,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              _singleModel.aciklar
                                                                          .contains(
                                                                              index) !=
                                                                      false
                                                                  ? _singleModel
                                                                      .ipucu[
                                                                          index]
                                                                      .toString()
                                                                      .toUpperCase()
                                                                  : _singleModel.tahmin[
                                                                              index] !=
                                                                          null
                                                                      ? _singleModel
                                                                          .tahmin[
                                                                              index]
                                                                          .toString()
                                                                          .toUpperCase()
                                                                      : " ",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Outfit",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      _singleModel
                                                                          .renk,
                                                                  fontSize: 25),
                                                            ),
                                                            Container(
                                                              height: 5,
                                                              width: 25,
                                                              color:
                                                                  _singleModel
                                                                      .renk,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox(
                                                      width: 10,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ]),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          print(_singleModel.kontrolSurec);
                                          if (!_singleModel.kontrolSurec) {
                                            int sayi = _singleModel.randomSayi(
                                                _singleModel.ipucu,
                                                _singleModel.aciklar);
                                            _singleModel.aciklar.add(sayi);
                                            if (_singleModel.tahmin.length +
                                                    _singleModel
                                                        .aciklar.length ==
                                                _singleModel.ipucu.length) {
                                              for (int i = 0;
                                                  i <
                                                      _singleModel
                                                          .aciklar.length;
                                                  i++) {
                                                _singleModel.tahmin[_singleModel
                                                    .aciklar[i]] = _singleModel
                                                        .ipucu.values
                                                        .toList()[
                                                    _singleModel.aciklar[i]];
                                              }
                                              _singleModel.kontrol();
                                            }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 204, 204, 204),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 30),
                                          child: const Text(
                                            "Harf Al",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Outfit",
                                            ),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    /*  MaterialButton(
                                      onPressed: () {},
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
                                          "Tahmin Et",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Outfit",
                                          ),
                                        ),
                                      ),
                                    ),*/
                                    const Expanded(
                                      child: SizedBox(
                                        height: 40,
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/logo.png"),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Tebrikler Tüm Bilmecelerimizi Çözdünüz.\nDaha Fazlası İçin Lütfen Beklemede Kalın!",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Outfit",
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Puanınız: $toplamPuan",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontFamily: "Outfit",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/logo.png"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Kelimeler Getirilemedi!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Outfit",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/logo.png"),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Kelimeler Getiriliyor",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Outfit",
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
