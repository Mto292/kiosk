# Kiosk 

A Flutter plugin to enable, disable, and check Kiosk Mode on Android devices. Kiosk Mode restricts the user to a single app, preventing them from accessing other apps or settings on the device.

## Features

- Start Kiosk Mode
- Stop Kiosk Mode
- Check if the device is in Kiosk Mode

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  kiosk: ^0.0.1
```

Start Kiosk Mode
```dart
Kiosk.instance.startKioskMode();
```

Stop Kiosk Mode
```dart
Kiosk.instance.stopKioskMode();
```

Check if the device is in Kiosk Mode
```dart
Kiosk.instance.isInKioskMode();
```
