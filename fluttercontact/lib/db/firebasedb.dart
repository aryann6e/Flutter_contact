import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ContactModel {
  String username;
  String pNo;
  String id;

  ContactModel({required this.username, required this.pNo, this.id = "1234"});
}

class FirebaseDb with ChangeNotifier {
  final databaseRef = FirebaseDatabase.instance.ref();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<ContactModel> _contactList = [];
  List<ContactModel> get contacts {
    return [..._contactList];
  }

  void getcontact() {
    databaseRef.child('Contacts/$uid').orderByValue().onValue.listen(
      (data) {
        final List<ContactModel> fetchedPostList = [];
        final Contactdata = data.snapshot.value as Map<dynamic, dynamic>?;
        print(Contactdata);
        Contactdata!.forEach(
          (key, value) {
            fetchedPostList.add(
              ContactModel(
                username: value["username"],
                pNo: value["pno"],
                id: value["id"],
              ),
            );
          },
        );

        _contactList = fetchedPostList;
        notifyListeners();
      },
    );
  }

  Future<bool> addContact(ContactModel user) async {
    bool success = true;
    try {
      final userNode = databaseRef.child('Contacts/$uid').push();
      final key = userNode.key;
      await userNode.set({
        "username": user.username,
        "pno": user.pNo,
        "id": key,
      });
      notifyListeners();
    } catch (error) {
      success = false;
    }
    return success;
  }

  Future<bool> updateContact(ContactModel user) async {
    bool success = true;
    try {
      await databaseRef.child('Contacts/$uid/${user.id}').update({
        "username": user.username,
        "pno": user.pNo,
        "id": user.id,
      });
      notifyListeners();
    } catch (_) {
      success = false;
    }
    return success;
  }

  Future<bool> deleteContact(ContactModel user) async {
    bool success = true;
    try {
      await databaseRef.child('Contacts/$uid/${user.id}').remove();
      notifyListeners();
    } catch (_) {
      success = false;
    }
    return success;
  }
}
