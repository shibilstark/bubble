import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  static final _internetInfoProvider = Connectivity();
  static checkInternetConnection() async =>
      (await _internetInfoProvider.checkConnectivity().then(
            (value) =>
                value == ConnectivityResult.wifi ||
                value == ConnectivityResult.mobile,
          ));
}
