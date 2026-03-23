import 'package:base_app/core/utils/alerts.dart';
import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> isBiometricSupported() async {
    return await _auth.isDeviceSupported();
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  static Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
          biometricOnly:true ,
      );
      return didAuthenticate;
    } catch (e) {
      Alerts.showSnackBar("Biometric authentication failed. Try again!"
      );
      return false;
    }
  }
}