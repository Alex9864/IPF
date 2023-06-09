import 'package:ipf/pages/image%20model/image_model.dart';
import 'package:ipf/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageModel(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: Colors.orange,
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
              scaffoldBackgroundColor: Colors.white
          ),
          home: WelcomePage(),
          debugShowCheckedModeBanner: false
      ),
    );
  }
}