import 'package:flutter/material.dart';

import 'package:fluttercontact/db/firebasedb.dart';
import 'package:fluttercontact/widget/snackbar.dart';
import 'package:provider/provider.dart';

class EditAccount extends StatefulWidget {
  static const routName = "EditAccount";
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final contact = ContactModel(username: "", pNo: "", id: "");

  Future<void> onPressedUpdate(BuildContext context) async {
    final valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    }
    _formKey.currentState!.save();

    final status = await Provider.of<FirebaseDb>(context, listen: false)
        .updateContact(contact);
    _formKey.currentState!.reset();
    if (status) {
      snackbar(context, "Contact Updated");
    } else {
      snackbar(context, "Something went wrong");
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as ContactModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit contact",
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        child: Image.asset("assets/addcontact.png"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: routeData.username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter contact name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Contact name',
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorRadius: const Radius.circular(0),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onSaved: (newValue) {
                          contact.username = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: routeData.pNo,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Phone no.';
                          }
                          if (value.length != 10) {
                            return 'Invalid Phone no.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone no.',
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorRadius: const Radius.circular(0),
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        onSaved: (newValue) {
                          contact.pNo = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: TextButton.icon(
                          onPressed: () async {
                            contact.id = routeData.id;
                            await onPressedUpdate(context);
                          },
                          icon: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
