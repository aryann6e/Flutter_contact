import 'package:flutter/material.dart';
import 'package:fluttercontact/Ui/accountScreen.dart';
import 'package:fluttercontact/Ui/addcontact.dart';
import 'package:fluttercontact/Ui/editscreen.dart';
import 'package:fluttercontact/db/firebasedb.dart';
import 'package:fluttercontact/widget/snackbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> contacts = [];
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseDb>(context, listen: false).getcontact();
  }

  @override
  Widget build(BuildContext context) {
    contacts = Provider.of<FirebaseDb>(context, listen: true).contacts;

    print(contacts);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Contacts",
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AccountScreen.routeName);
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: contacts.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final data = contacts[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    EditAccount.routName,
                                    arguments: data);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                          IconButton(
                            onPressed: () async {
                              final status = await Provider.of<FirebaseDb>(
                                      context,
                                      listen: false)
                                  .deleteContact(data);

                              if (status) {
                                snackbar(context, "Contact Deleted");
                                ;
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      tileColor: Colors.blueGrey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        data.username,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data.pNo,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Addcontact.routName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
