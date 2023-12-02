import 'package:flutter/material.dart';
import 'package:offi_memoire/restaurants_element/add%20to%20card.dart';
import 'package:offi_memoire/restaurants_element/element_menu_container%20with%20delete.dart';

class Shopping extends StatefulWidget {
  List order;
  String? restaurantName;
  Shopping({super.key, required this.order, required this.restaurantName});
  @override
  State<Shopping> createState() =>
      _ShoppingState(this.order, this.restaurantName);
}

class _ShoppingState extends State<Shopping> {
  List order;
  String? restaurantName;
  _ShoppingState(
    this.order,
    this.restaurantName,
  );
  @override
  void initState() {
    // getData();
    super.initState();
  }

  String imageNotFound =
      "https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708";

  // void getData() async {
  //   // bool a;
  //   // collectionName == String ?a=true:a=false;
  //   // print("collection :: ${collectionName}, is he a string :: ${a}");
  //   // print("catigorie :: ${catigorieName}");
  //   CollectionReference restaurant_menu = FirebaseFirestore.instance
  //       .collection(collectionName.toString())
  //       .doc(catigorieName.toString())
  //       .collection(catigorieName.toString());
  //   await restaurant_menu.snapshots().listen((event) {
  //     menu.clear();
  //     event.docs.forEach((element) {
  //       setState(() {
  //         print("data :: ${element.data()}");
  //         menu.add(element.data());
  //       });
  //     });
  //   });
  // }

  Future<bool> _onPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
          backgroundColor: Colors.orange[200],
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return Add_to_card(
                  order: order,
                  restaurantName: restaurantName,
                );
              },
            )),
            backgroundColor: Colors.orange,
            // ignore: prefer_const_constructors
            label: Text(
              "Add to card",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 40,
                color: Colors.black54,
                fontFamily: 'Signatra',
                letterSpacing: 3,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.orange[500],
            title: const Center(
              child: Text(
                "Order space",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  fontFamily: 'Signatra',
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: order.length,
            itemBuilder: (context, index) {
              if (order[index]["image"].toString().isEmpty) {
                order[index]["image"] = imageNotFound;
              }
              return Element_of_menu(
                name: order[index]["name"],
                price: order[index]["price"],
                description: order[index]["description"],
                imageURL: order[index]["image"],
                list: order,
                onpress: (data) {
                  setState(() {
                    order = data;
                  });
                },
                // collectionName: collectionName,
                // docName: catigorieName,
              );
            },
          )),
    );
  }
}
