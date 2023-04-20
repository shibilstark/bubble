import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  static final _internetServiceProvider = Connectivity();
  static checkInternetConnection() async =>
      (await _internetServiceProvider.checkConnectivity().then(
            (value) =>
                value == ConnectivityResult.wifi ||
                value == ConnectivityResult.mobile,
          ));
}
