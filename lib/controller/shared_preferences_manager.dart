import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';

/* About this Class: Shared Preferences is a library used to store data locally to retrieve it later when needed*/

class SharedPrefsManager {
  static SharedPreferences? _sharedPrefs;

  static init() {
    // The ??= operator is used to asign a value to a variable if it is null.

    restoreAllConfigsFromLocal();
  }

  // This getter is the used to acces shared preferences AKA local data copies from all other places in the APP. That's why _sharedPrefs is an static variable.
  static SharedPreferences? get instance => _sharedPrefs;

  // This method is used to get all the configurations on the App.
  static Future<bool> restoreAllConfigsFromLocal() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    String groupsData = await GroupController.getGroupsAsString(); 
    String alertsData = await AlertController.getAlertsAsString();

    await _sharedPrefs?.setString('groups', groupsData);
    await _sharedPrefs?.setString('alerts', alertsData);

    return true;
  }
  
  
  static Future<bool> restoreAllConfigsFromRemote(String email, String password) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    // TODO: Obtener el JSON de configuración desde Firebase para leer los datos, ahora mismo, los JSON en la carpeta de lib/data funcionan como placeholders para simular la obtención de datos
    

    String groupsData = await GroupController.getGroupsAsString(); 
    String alertsData = await AlertController.getAlertsAsString();

    await _sharedPrefs?.setString('groups', groupsData);
    await _sharedPrefs?.setString('alerts', alertsData);

    return true;
  }

  // Restore only one of the local configurations
  static Future<bool> restoreConfig(String targetConfig) async {
    return true;
  }
}
