import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontact/AuthScreens/AuthWidgets/ShowScreenOnUserData.dart';
import 'package:fluttercontact/AuthScreens/resetPasswordScreen.dart';
import 'package:fluttercontact/FireBaseAuthFunctions.dart';
import 'package:fluttercontact/Ui/accountScreen.dart';
import 'package:fluttercontact/Ui/addcontact.dart';
import 'package:fluttercontact/Ui/editscreen.dart';
import 'package:fluttercontact/db/firebasedb.dart';
import 'package:fluttercontact/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Myapp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthFunction(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseDb(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorkey,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.blue,
          hintColor: Colors.white,
          canvasColor: Colors.grey.shade200,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              color: Colors.white,
              fontSize: 18.5,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              color: Colors.blue,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
            bodySmall: TextStyle(
              color: Colors.blue,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const ShowScreenOnUserData(),
        routes: {
          resetPasswordScreen.routeName: (context) => resetPasswordScreen(),
          AccountScreen.routeName: (context) => const AccountScreen(),
          Addcontact.routName: (context) => const Addcontact(),
          EditAccount.routName: (context) => const EditAccount()
        },
      ),
    );
  }
}
