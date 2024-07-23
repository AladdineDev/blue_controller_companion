import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerConfigurationUploadScreen extends ConsumerStatefulWidget {
  const ControllerConfigurationUploadScreen({super.key});

  @override
  ConsumerState<ControllerConfigurationUploadScreen> createState() =>
      _ControllerConfigurationUploadScreenState();
}

class _ControllerConfigurationUploadScreenState
    extends ConsumerState<ControllerConfigurationUploadScreen> {
  BluetoothDevice? _device;
  BluetoothCharacteristic? _characteristic;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 4),
      androidUsesFineLocation: true,
    );

    FlutterBluePlus.onScanResults.listen(
      (results) {
        for (ScanResult r in results) {
          if (r.device.platformName == "Blue Controller") {
            FlutterBluePlus.stopScan();
            _connectToDevice(r.device);
            break;
          }
        }
      },
      onError: (e) => print(e),
    );
  }

  void _connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      _device = device;
    });

    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          setState(() {
            _characteristic = characteristic;
          });
        }
      }
    }

    // Create JSON configuration
    final jsonString = jsonEncode({
      'buttonPins': [0, 3, 4, 5, 14, 15, 16, 17, 18, 19, 21, 22, 23, 25, 26, 27]
    });

    _sendConfig(jsonString);
  }

  void _sendConfig(String config) async {
    if (_characteristic != null) {
      List<int> bytes = utf8.encode(config);
      await _characteristic!.write(bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Configuration sent to ESP32')),
        );
      }
    }
  }

  @override
  void dispose() {
    _device?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESP32 Bluetooth Config'),
      ),
      body: Center(
        child: _device != null
            ? Text('Connected to ${_device!.platformName}')
            : const CircularProgressIndicator(),
      ),
    );
  }
}
