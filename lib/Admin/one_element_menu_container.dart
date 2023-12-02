import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Element_of_menu extends StatelessWidget {
  String? name;
  String? description;
  int? price;
  String? imageURL;
  String? collectionName;
  String? docName;
  Element_of_menu(
      {super.key,
      this.description,
      this.imageURL,
      this.name,
      this.price,
      this.collectionName,
      this.docName});

  String? docID;
  List list = [];
  deleteItem() async {
    CollectionReference collection = FirebaseFirestore.instance
        .collection(collectionName!)
        .doc(docName!)
        .collection(docName!);
    await collection
        .where("image", isEqualTo: imageURL.toString())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        list.add(element.id);
      });
    });
    collection.doc(list[0].toString()).delete();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 60,
      //container hold each element of the menu
      height: 165,
      margin: EdgeInsets.all(10),
      // ignore: prefer_const_constructors
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 244, 242, 242)),
      child: Row(
        // hold the data
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            //to fix the height and width of the menu element
            height: 110,
            width: 150,
            child: Image.network(
              imageURL!,
              fit: BoxFit.fill,
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              Text(
                name!,
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 8,
              ),
              Text(
                description!,
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "${price} DA ",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      try {
                        deleteItem();
                      } catch (e) {
                        print(e);
                      }
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.delete,
                      size: 30.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

// class Icon_Button extends StatelessWidget {
//   bool there_product = true;
//   Icon_Button({super.key,required this.there_product});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
