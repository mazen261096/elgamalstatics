import '../models/car.dart';

class AppPreferences {

  AppPreferences._internal();

  static final AppPreferences _instance =
  AppPreferences._internal(); // singleton or single instance

  factory AppPreferences() => _instance;





}