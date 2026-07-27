import 'package:otp/otp.dart';

import 'package:arculus/utils/app_database.dart';

class OtpService {
  static String generateTotp(Account account) {
    try {
      final algo = Algorithm.values.byName('SHA1');
      final code = OTP.generateTOTPCodeString(
        account.secret,
        DateTime.now().millisecondsSinceEpoch,
        length: account.digits,
        interval: account.interval,
        algorithm: algo,
        isGoogle: true,
      );
      return code;
    } catch (e) {
      return '------';
    }
  }

  static String generateHotp(Account account, {int? counter}) {
    return '123456';
  }

  static int secondsRemaining(int period) {
    final ms = DateTime.now().millisecondsSinceEpoch;
    final secondsInPeriod = (ms ~/ 1000) % period;
    return period - secondsInPeriod;
  }

  static bool isValidSecret(String secret) {
    final normalized = secret.trim().replaceAll(' ', '').toUpperCase();

    return RegExp(r'^[A-Z2-7]+=*$').hasMatch(normalized) && normalized.isNotEmpty;
  }
}
