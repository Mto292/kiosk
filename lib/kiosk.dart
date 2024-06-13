import 'kiosk_platform_interface.dart';

class Kiosk {
  static Kiosk? _instance;

  static Kiosk get instance => _instance ??= Kiosk._();

  Kiosk._();

  Future<bool?> startKioskMode() {
    return KioskPlatform.instance.startKioskMode();
  }

  Future<bool?> stopKioskMode() {
    return KioskPlatform.instance.stopKioskMode();
  }

  Future<bool?> isInKioskMode() {
    return KioskPlatform.instance.isInKioskMode();
  }
}
