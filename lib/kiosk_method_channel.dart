import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'kiosk_platform_interface.dart';

/// An implementation of [KioskPlatform] that uses method channels.
class MethodChannelKiosk extends KioskPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.mto.kiosk/kiosk');

  @override
  Future<bool?> stopKioskMode() async {
    return await methodChannel.invokeMethod<bool>('stopKioskMode');
  }

  @override
  Future<bool?> startKioskMode() async {
    return await methodChannel.invokeMethod<bool>('startKioskMode');
  }

  @override
  Future<bool?> isInKioskMode() async {
    return await methodChannel.invokeMethod<bool>('isInKioskMode');
  }
}
