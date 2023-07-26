import 'package:connectivity_plus/connectivity_plus.dart';

class Utils {
  static Future<bool> checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected = connectivityResult != ConnectivityResult.none;

    return isConnected;
  }
}
