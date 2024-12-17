import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future setUpLocator() async {
  ///------Injecting SharedPref instance
  SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerSingleton(preferences);
}
