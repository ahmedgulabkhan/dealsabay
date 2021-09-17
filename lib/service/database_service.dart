import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // final String uid;
  // DatabaseService({required this.uid});

  // Collection references
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
  final CollectionReference dealsCollection = FirebaseFirestore.instance.collection('deals');
  final CollectionReference apparelDealsCollection = FirebaseFirestore.instance.collection('apparel-deals');
  final CollectionReference babyDealsCollection = FirebaseFirestore.instance.collection('baby-deals');
  final CollectionReference beautyDealsCollection = FirebaseFirestore.instance.collection('beauty-deals');
  final CollectionReference booksDealsCollection = FirebaseFirestore.instance.collection('books-deals');
  final CollectionReference computersDealsCollection = FirebaseFirestore.instance.collection('computers-deals');
  final CollectionReference furnitureDealsCollection = FirebaseFirestore.instance.collection('furniture-deals');
  final CollectionReference moviesAndTvDealsCollection = FirebaseFirestore.instance.collection('moviesandtv-deals');
  final CollectionReference homeAndKitchenDealsCollection = FirebaseFirestore.instance.collection('homeandkitchen-deals');
  final CollectionReference fashionDealsCollection = FirebaseFirestore.instance.collection('fashion-deals');
  final CollectionReference electronicsDealsCollection = FirebaseFirestore.instance.collection('electronics-deals');
  final CollectionReference videoGamesDealsCollection = FirebaseFirestore.instance.collection('videogames-deals');
  final CollectionReference watchesDealsCollection = FirebaseFirestore.instance.collection('watches-deals');
  final CollectionReference miscellaneousDealsCollection = FirebaseFirestore.instance.collection('miscellaneous-deals');

  // update user data
  Future updateUserData(String uid, String fullName, String email, String mobileNumber) async {
    return await userCollection.doc(uid).set({
      'userId': uid,
      'fullName': fullName,
      'email': email,
      'mobile': mobileNumber
    });
  }

  // get user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  // get the deals data from firestore
  Future getDealsFromFirestore() async {
    return dealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the apparel-deals data from firestore
  Future getApparelDealsFromFirestore() async {
    return apparelDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the baby-deals data from firestore
  Future getBabyDealsFromFirestore() async {
    return babyDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the beauty-deals data from firestore
  Future getBeautyDealsFromFirestore() async {
    return beautyDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the books-deals data from firestore
  Future getBooksDealsFromFirestore() async {
    return booksDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the computers-deals data from firestore
  Future getComputersDealsFromFirestore() async {
    return computersDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the furniture-deals data from firestore
  Future getFurnitureDealsFromFirestore() async {
    return furnitureDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the moviesandtv-deals data from firestore
  Future getMovesAndTVDealsFromFirestore() async {
    return moviesAndTvDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the homeandkitchen-deals data from firestore
  Future getHomeAndKitchenDealsFromFirestore() async {
    return homeAndKitchenDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the fashion-deals data from firestore
  Future getFashionDealsFromFirestore() async {
    return fashionDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the electronics-deals data from firestore
  Future getElectronicsDealsFromFirestore() async {
    return electronicsDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the videogames-deals data from firestore
  Future getVideoGamesDealsFromFirestore() async {
    return videoGamesDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the watches-deals data from firestore
  Future getWatchesDealsFromFirestore() async {
    return watchesDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }

  // get the miscellaneous-deals data from firestore
  Future getMiscellaneousDealsFromFirestore() async {
    return miscellaneousDealsCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first["Items"];
    });
  }
}