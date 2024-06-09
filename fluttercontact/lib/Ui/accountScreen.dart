import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = "AccountScreen";
  const AccountScreen({super.key});

  Widget buildtitle(
      BuildContext context, String field, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.blueGrey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: Text(
          field,
          style: const TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          text,
          style: const TextStyle(
              color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Colors.black,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userCred = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 175,
              child: Image.asset("assets/account.png"),
            ),
            const SizedBox(
              height: 30,
            ),
            buildtitle(context, "Name", userCred.displayName!, Icons.person),
            buildtitle(context, "E-mail", userCred.email!, Icons.email),
            buildtitle(
              context,
              "Register On",
              userCred.metadata.creationTime!.toString(),
              Icons.alarm,
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
