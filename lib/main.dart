import 'package:flutter/material.dart';
import 'package:vistas_amatista/screens/login_screen.dart';
import 'package:vistas_amatista/screens/not_found_screen.dart';
import 'package:vistas_amatista/screens/signup_screen.dart';
import 'package:vistas_amatista/screens/startup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      /*Here we define the value of the initial route and all the avaliable routes 
      that allow us to display all the screen of the app*/
      initialRoute: '/startup',
      routes: {
        '/startup': (context) => const StartupScreen(),
        '/login': (context) => const LogInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/not_found': (context) => const NotFoundScreen()
      },
      //This allow us to define a default page when an unexisting route is requested
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const StartupScreen(),
        );
      }, 
    );
  }
}

