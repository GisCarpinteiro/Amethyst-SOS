import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/blocs/alert_blocs/alert_list/alert_list_bloc.dart';
import 'package:vistas_amatista/blocs/alert_blocs/alert_menu/alert_menu_bloc.dart';
import 'package:vistas_amatista/blocs/group_blocs/group_menu/group_menu_bloc.dart';
import 'package:vistas_amatista/blocs/group_blocs/group_list/group_list_bloc.dart';
import 'package:vistas_amatista/blocs/login_blocs/login_bloc/login_bloc.dart';
import 'package:vistas_amatista/blocs/routine_blocs/routine_list/routine_list_bloc.dart';
import 'package:vistas_amatista/blocs/trigger_blocs/trigger_config_bloc.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/screens/alerts/alert_menu.dart';
import 'package:vistas_amatista/screens/alerts/alert_list.dart';
import 'package:vistas_amatista/screens/groups/group_list.dart';
import 'package:vistas_amatista/screens/groups/group_menu.dart';
import 'package:vistas_amatista/screens/routines/routine_list.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/* Esta es la clase Main de la aplicación, en ella definimos las rutas por medio 
de las cuales podemos acceder a las otras vistas */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Logging
  initLogs();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SharedPrefsManager.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => TriggerConfigBloc()),
        BlocProvider(create: (_) => AlertListBloc()),
        BlocProvider(create: (_) => AlertMenuBloc()),
        BlocProvider(create: (_) => GroupListBloc()),
        BlocProvider(create: (_) => GroupMenuBloc()),
        BlocProvider(create: (_) => RoutineListBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        /*Here we define the value of the initial route and all the avaliable routes 
        that allow us to display all the screen of the app*/
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
          '/trigger_settings/voice_recognition': (context) => const VoiceTriggerSettingsScreen(),
          '/alert_list': (context) => const AlertSettingsScreen(),
          '/alert_menu': (context) => const AlertMenuScreen(),
          '/group_list': (context) => const GroupListScreen(),
          '/group_menu': (context) => const GroupMenuScreen(),
          '/routine_list': (context) => const RoutineListScreen()
        },
        initialRoute: '/test_demo',
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

// Enabling The use of logs on app
Future<void> initLogs() async {
  await FlutterLogs.initLogs(
      logLevelsEnabled: [LogLevel.INFO, LogLevel.WARNING, LogLevel.ERROR, LogLevel.SEVERE],
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: DirectoryStructure.FOR_DATE,
      logTypesEnabled: ["device", "network", "errors"],
      logFileExtension: LogFileExtension.LOG,
      logsWriteDirectoryName: "MyLogs",
      logsExportDirectoryName: "MyLogs/Exported",
      debugFileOperations: true,
      isDebuggable: true);
}
