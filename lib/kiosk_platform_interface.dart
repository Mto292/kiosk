import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'kiosk_method_channel.dart';

abstract class KioskPlatform extends PlatformInterface {
  /// Constructs a KioskPlatform.
  KioskPlatform() : super(token: _token);

  static final Object _token = Object();

  static KioskPlatform _instance = MethodChannelKiosk();

  /// The default instance of [KioskPlatform] to use.
  ///
  /// Defaults to [MethodChannelKiosk].
  static KioskPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KioskPlatform] when
  /// they register themselves.
  static set instance(KioskPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> startKioskMode() {
    throw UnimplementedError('startKioskMode() has not been implemented.');
  }

  Future<bool?> stopKioskMode() {
    throw UnimplementedError('stopKioskMode() has not been implemented.');
  }

  Future<bool?> isInKioskMode() {
    throw UnimplementedError('isInKioskMode() has not been implemented.');
  }
}
