import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/blocs/trigger_config/trigger_config_bloc.dart';
import 'package:vistas_amatista/screens/wizard/confirm_email.dart';
import 'package:vistas_amatista/screens/demo_menu.dart';
import 'package:vistas_amatista/screens/home.dart';
import 'package:vistas_amatista/screens/triggers/disconnection_trigger_settings.dart';
import 'package:vistas_amatista/screens/triggers/trigger_settings.dart';
import 'package:vistas_amatista/screens/triggers/trigger_tests.dart';
import 'package:vistas_amatista/screens/triggers/voice_trigger_settings_screen.dart';
import 'package:vistas_amatista/screens/wizard/trust_group_wizard.dart';
import 'package:vistas_amatista/screens/wizard/emergency_message_config.dart';
import 'package:vistas_amatista/screens/logging/login.dart';
import 'package:vistas_amatista/screens/not_found.dart';
import 'package:vistas_amatista/screens/wizard/signup.dart';
import 'package:vistas_amatista/screens/wizard/signup2.dart';
import 'package:vistas_amatista/screens/logging/startup.dart';

/* Esta es la clase Main de la aplicación, en ella definimos las rutas por medio 
de las cuales podemos acceder a las otras vistas */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => TriggerConfigBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        /*Here we define the value of the initial route and all the avaliable routes 
        that allow us to display all the screen of the app*/
        initialRoute: '/test_demo',
        routes: {
          '/test_demo': (context) => const DemoScreen(),
          '/home': (context) => const HomeScreen(),
          '/startup': (context) => const StartupScreen(),
          '/login': (context) => const LogInScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/signup2': (context) => const SignUpScreen2(),
          '/confirm_email': (context) => const ConfirmEmailScreen(),
          '/not_found': (context) => const NotFoundScreen(),
          '/emergency_message_wizard': (context) => const EmergencyMessageWizardScreen(),
          '/trust_group_wizard': (context) => const CreateTrustGroupWizardScreen(),
          '/trigger_settings': (context) => const TriggerSettingsScreen(),
          '/trigger_settings/internet_disconnection': (context) => const DiscconectTriggerSettingsScreen(),
          '/trigger_test': (context) => const TriggerTestScreen(),
          '/trigger_settings/voice_recognition': (context) => const VoiceTriggerSettingsScreen()
        },
        //This allow us to define a default page when an unexisting route is requested
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const NotFoundScreen(),
          );
        },
      ),
    );
  }
}
