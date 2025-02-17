// import 'package:flutter/material.dart';
// import 'package:nom_du_projet/auth/register.dart';
// import 'package:nom_du_projet/home/homepage.dart';
// import 'package:nom_du_projet/intro.dart';  // Assurez-vous que ce chemin est correct
// import 'package:nom_du_projet/provider/favorisProvider.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:nom_du_projet/provider/authprovider.dart';

// // void main() => runApp(MyApp());  // Passez MyApp à runApp

// void main() => runApp(
//   MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (context) => AuthProvider()),
//       ChangeNotifierProvider(create: (context) => FavoritesProvider()),

//     ],
//     child: MyApp(),
//   ),
// );



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RegisterPage(), 
//       // home: RegisterPage(),  // Assurez-vous que IntroPage est bien défini dans intro.dart

//       // ajoutez ici d'autres configurations de MaterialApp si nécessaire
//     );
//   }
// }



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:nom_du_projet/auth/register.dart';
import 'package:nom_du_projet/home/homepage.dart';
import 'package:nom_du_projet/intro.dart';  // Assurez-vous que ce chemin est correct
import 'package:nom_du_projet/provider/favorisProvider.dart';
import 'package:provider/provider.dart';
import 'package:nom_du_projet/provider/authprovider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => FavoritesProvider()),
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _linkSubscription;

  @override
  void initState() {
    super.initState();
    // Démarre l'écoute des liens profonds
    _initDeepLinkListener();
  }

  // Fonction pour écouter les liens profonds
  void _initDeepLinkListener() async {
    _linkSubscription = linkStream.listen((String? link) {
      if (link != null && link.contains("paiement-termine")) {
        // Redirige vers la page spécifique après paiement
        Navigator.pushReplacementNamed(context, '/page-apres-paiement');
      }
    }, onError: (err) {
      print('Erreur de lien profond : $err');
    });
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),  // Page d'accueil
      routes: {
        '/page-apres-paiement': (context) => PaymentConfirmationPage(),
        // Ajoutez d'autres routes ici si nécessaire
      },
    );
  }
}

class PaymentConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation de paiement'),
      ),
      body: Center(
        child: Text('Merci pour votre paiement !'),
      ),
    );
  }
}

