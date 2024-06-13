import 'package:flutter/material.dart';
import 'package:kiosk/kiosk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? kioskMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      kioskMode = await Kiosk.instance.isInKioskMode();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Kiosk Mode: $kioskMode'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  kioskMode = await Kiosk.instance.isInKioskMode();
                  setState(() {});
                },
                child: const Text('Check Kiosk Mode'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  Kiosk.instance.startKioskMode();
                },
                child: const Text('Start Kiosk Mode'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Kiosk.instance.stopKioskMode();
                },
                child: const Text('Stop Kiosk Mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
