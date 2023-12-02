import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/restaurants_element/element_of_menu_with_addsign.dart';
import 'package:offi_memoire/restaurants_element/shopping.dart';

class Profile extends StatefulWidget {
  String? restaurantName;

  Profile({Key? key, required this.restaurantName}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(restaurantName: restaurantName);
}

class _ProfileState extends State<Profile> {
  _ProfileState({this.restaurantName});
  String? _logo;
  @override
  void initState() {
    getData();
    if (restaurantName == "Havana") {_logo = 'images/havana_logo.png';}
    else if(restaurantName == "manarchy"){_logo = 'images/manarchy/manarchy_logo.png';}
    else if(restaurantName == "odelice"){_logo = 'images/odelice/odelice_logo.png';}
    else{_logo = 'images/broaster/broaster_logo.png';}
    super.initState();
  }

  String? restaurantName;

  List menu_pizza = [];
  List menu_burger = [];
  List menu_plats = [];
  List menu_boisson = [];
  List menu_tacos = [];
  List order = [];
  void getData() async { //get data from firebase
    CollectionReference havanaref_pizza = FirebaseFirestore.instance
        .collection(restaurantName.toString())
        .doc("pizza")
        .collection("pizza");
    CollectionReference havanaref_burger = FirebaseFirestore.instance
        .collection(restaurantName.toString())
        .doc("burger")
        .collection("burger");
    CollectionReference havanaref_plats = FirebaseFirestore.instance
        .collection(restaurantName.toString())
        .doc("plat")
        .collection("plat");

    CollectionReference havanaref_boisson = FirebaseFirestore.instance
        .collection(restaurantName.toString())
        .doc("boisson")
        .collection("boisson");
    CollectionReference havanaref_tacos = FirebaseFirestore.instance
        .collection(restaurantName.toString())
        .doc("tacos")
        .collection("tacos");
    await havanaref_burger.snapshots().listen((event) {
      menu_burger.clear();
      event.docs.forEach((element) {
        setState(() {
          menu_burger.add(element.data());
        });
      });
      // if (menu_burger.isEmpty) {
      //   menu_burger.add({
      //     "name":"empty",
      //     "description":"empty",
      //     "price":0,
      //     "image":"https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708",
      //   });
      // }
    });
    await havanaref_pizza.snapshots().listen((event) {
      menu_pizza.clear();

      event.docs.forEach((element) {
        setState(() {
          menu_pizza.add(element.data());
        });
      });
      // if (menu_pizza.isEmpty) {
      //   menu_pizza.add({
      //     "name":"empty",
      //     "description":"empty",
      //     "price":0,
      //     "image":"https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708",
      //   });
      // }
    });

    await havanaref_plats.snapshots().listen((event) {
      menu_plats.clear();

      event.docs.forEach((element) {
        setState(() {
          menu_plats.add(element.data());
        });
      });
      // if (menu_plats.isEmpty) {
      //   menu_plats.add({
      //     "name":"empty",
      //     "description":"empty",
      //     "price":0,
      //     "image":"https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708",
      //   });
      // }
    });
    await havanaref_boisson.snapshots().listen((event) {
      menu_boisson.clear();
      event.docs.forEach((element) {
        setState(() {
          menu_boisson.add(element.data());
        });
      });
      // if (menu_boisson.isEmpty) {
      //   menu_boisson.add({
      //     "name":"empty",
      //     "description":"empty",
      //     "price":0,
      //     "image":"https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708",
      //   });
      // }
    });
    await havanaref_tacos.snapshots().listen((event) {
      menu_tacos.clear();
      event.docs.forEach((element) {
        setState(() {
          menu_tacos.add(element.data());
        });
      });
      // if (menu_tacos.isEmpty) {
      //   menu_tacos.add({
      //     "name":"empty",
      //     "description":"empty",
      //     "price":0,
      //     "image":"https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708",
      //   });
      // }
    });
  }

  Future<bool> _onPop() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> profilekey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        key: profilekey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Shopping(order: order,restaurantName: restaurantName),
            ));
          },
          backgroundColor: Colors.orange,
          // ignore: prefer_const_constructors
          child: Icon(Icons.add_shopping_cart,
              color: Colors.white,
              shadows: const [Shadow(color: Colors.orange, blurRadius: 10)]),
        ),
        body: DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    // height: 200,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20))),
                    child: Image.asset(
                      _logo!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      TabBar(
                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          const Tab(
                            icon: Icon(
                              Icons.fastfood_outlined,
                              color: Colors.orange,
                            ),
                          ),
                          const Tab(
                              icon: Icon(
                            Icons.local_pizza,
                            color: Colors.orange,
                          )),
                          const Tab(
                            icon: ImageIcon(
                                AssetImage("images/menu/tacosIcon.png"),
                                color: Colors.orange),
                          ),
                          const Tab(
                              icon: Icon(
                            Icons.food_bank,
                            color: Colors.orange,
                          )),
                          const Tab(
                              icon: Icon(
                            Icons.local_drink,
                            color: Colors.orange,
                          )),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          // grey container hold the menu
                          color: Color.fromARGB(255, 223, 214, 214),
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                itemCount: menu_burger.length,
                                itemBuilder: (context, index) {
                                  return Element_of_menu(
                                    name: menu_burger[index]["name"],
                                    price: menu_burger[index]["price"],
                                    description: menu_burger[index]
                                        ["description"],
                                    imageURL: menu_burger[index]["image"],
                                    onButtonPressed: (p0) {
                                      order.add(p0);
                                    },
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: menu_pizza.length,
                                itemBuilder: (context, index) {
                                  return Element_of_menu(
                                    name: menu_pizza[index]["name"],
                                    price: menu_pizza[index]["price"],
                                    description: menu_pizza[index]["description"],
                                    imageURL: menu_pizza[index]["image"],
                                    onButtonPressed: (p0) {
                                      order.add(p0);
                                    },
                                  );
                                },
                              ),
                              ListView.builder(
                                  itemCount: menu_tacos.length,
                                  itemBuilder: (context, index) {
                                    return Element_of_menu(
                                      name: menu_tacos[index]["name"],
                                      price: menu_tacos[index]["price"],
                                      description: menu_tacos[index]
                                          ["description"],
                                      imageURL: menu_tacos[index]["image"],
                                      onButtonPressed: (p0) {
                                        order.add(p0);
                                      },
                                    );
                                  }),
                              ListView.builder(
                                itemCount: menu_plats.length,
                                itemBuilder: (context, index) {
                                  return Element_of_menu(
                                    name: menu_plats[index]["name"],
                                    price: menu_plats[index]["price"],
                                    description: menu_plats[index]["description"],
                                    imageURL: menu_plats[index]["image"],
                                    onButtonPressed: (p0) {
                                      order.add(p0);
                                    },
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: menu_boisson.length,
                                itemBuilder: (context, index) {
                                  return Element_of_menu(
                                    name: menu_boisson[index]["name"],
                                    price: menu_boisson[index]["price"],
                                    description: menu_boisson[index]
                                        ["description"],
                                    imageURL: menu_boisson[index]["image"],
                                    onButtonPressed: (p0) {
                                      order.add(p0);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
