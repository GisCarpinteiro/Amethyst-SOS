import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';

/* About this Class: Shared Preferences is a library used to store data locally to retrieve it later when needed*/

class SharedPrefsManager {
  static SharedPreferences? _sharedPrefs;

  static init() {
    restoreAllConfigsFromFirebase();
  }

  // This getter is the used to acces shared preferences AKA local data copies from all other places in the APP. That's why _sharedPrefs is an static variable.
  static SharedPreferences? get instance => _sharedPrefs;

  // This method is used to get all the configurations from firebase to the shared preferences variables on the app
  static Future<bool> restoreAllConfigsFromFirebase({String? password, String? email}) async {
    // TODO: (Gisel) Ahora mismo no hacemos nada con la contraseña y el usuario pero todo lo de abajo marcado con "!" debería ser remplazado para provenir de Firebase a través de una consulta con el usuario y contraseña
    // * Antes este método se llamaba restoreAllConfigsFromLocal pero no tenía mucho sentido ya que eso no era eso lo que hacía y le agregué los parámetros que ahora mismo son opcionales para hacer pruebas pero deben ser required
    String groupsData = await GroupController.getGroupsAsString(); // ! Replace with Firebase
    String alertsData = await AlertController.getAlertsAsString(); // ! Replace with Firebase
    String routinesData = await RoutineController.getRoutinesAsString(); // ! Replace with Firebase

    _sharedPrefs ??= await SharedPreferences.getInstance();
    await _sharedPrefs?.setString('groups', groupsData);
    await _sharedPrefs?.setString('alerts', alertsData);
    await _sharedPrefs?.setString('routines', routinesData);

    return true;
  }
}
