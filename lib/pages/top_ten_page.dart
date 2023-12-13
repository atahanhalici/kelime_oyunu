import 'package:flutter/material.dart';
import 'package:kelime_oyunu/viewmodels/user_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class TopTenPage extends StatefulWidget {
  const TopTenPage({Key? key}) : super(key: key);

  @override
  State<TopTenPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<TopTenPage> {
  @override
  Widget build(BuildContext context) {
    UserViewModel _userModel =
        Provider.of<UserViewModel>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    width: size.width / 2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/trophy.png",
                            width: 40,
                          ),
                          const Text(
                            "WordWars Top 10",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Outfit",
                            ),
                          ),
                          Image.asset(
                            "assets/trophy.png",
                            width: 40,
                          ),
                        ],
                      ),
                      ListView.separated(
                        itemCount: 11,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            color: index == 0
                                ? const Color.fromARGB(255, 255, 192, 0)
                                : index == 1
                                    ? Colors.grey
                                    : index == 2
                                        ? const Color.fromARGB(
                                            255, 205, 127, 50)
                                        : Colors.pink,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: index == 0
                                  ? SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: index == 0
                                                  ? const AssetImage(
                                                      "assets/golden_border.png")
                                                  : index == 1
                                                      ? const AssetImage(
                                                          "assets/silver_border.png")
                                                      : index == 2
                                                          ? const AssetImage(
                                                              "assets/bronze_border.png")
                                                          : const AssetImage(
                                                              "assets/empty_border.png"),
                                              child: const CircleAvatar(
                                                  radius: 17,
                                                  backgroundImage: AssetImage(
                                                      "assets/default.jpg")),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 35,
                                            left: 38,
                                            child: Transform.rotate(
                                              angle: math.pi / 4,
                                              child: Image.asset(
                                                "assets/king.png",
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: index == 0
                                              ? const AssetImage(
                                                  "assets/golden_border.png")
                                              : index == 1
                                                  ? const AssetImage(
                                                      "assets/silver_border.png")
                                                  : index == 2
                                                      ? const AssetImage(
                                                          "assets/bronze_border.png")
                                                      : const AssetImage(
                                                          "assets/empty_border.png"),
                                          child: const CircleAvatar(
                                              radius: 17,
                                              backgroundImage: AssetImage(
                                                  "assets/default.jpg")),
                                        ),
                                      ),
                                    ),
                              title: Text(
                                "${index + 1}- atahanhalici",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Outfit",
                                ),
                              ),
                              trailing: const Text(
                                "200",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Outfit",
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
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
    );
  }
}
