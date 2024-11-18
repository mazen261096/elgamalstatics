import '../models/car.dart';
import 'package:process_run/shell.dart';
class AppPreferences {

  AppPreferences._internal();

  static final AppPreferences _instance =
  AppPreferences._internal(); // singleton or single instance

  factory AppPreferences() => _instance;
static late String windowsUserName ;

  static Future<String> getWindowsUsername() async {
    final shell = Shell();

    // Execute the whoami command
    final result = await shell.run('echo %USERNAME%');

    // Extract and return the username
    if (result.isNotEmpty && result.first.stdout != null) {
      return result.first.stdout.trim();
    } else {
      throw Exception('Failed to get username');
    }
  }



}