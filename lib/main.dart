import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_online/components/helper.dart';
import 'package:library_online/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider(create: (_) => Helper(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Library',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xff1d3557),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xffe63946)),
            textTheme: GoogleFonts.loraTextTheme(Theme.of(context).textTheme)),
        home: const HomeScreen());
  }
}
