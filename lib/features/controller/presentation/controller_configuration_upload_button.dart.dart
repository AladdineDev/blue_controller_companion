import 'dart:convert';
import 'package:blue_controller_companion/features/auth/data/repository/jwt_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerConfigurationUploadButton extends ConsumerStatefulWidget {
  const ControllerConfigurationUploadButton({super.key});

  @override
  ConsumerState<ControllerConfigurationUploadButton> createState() =>
      _ControllerConfigurationUploadButtonState();
}

class _ControllerConfigurationUploadButtonState
    extends ConsumerState<ControllerConfigurationUploadButton> {
  BluetoothDevice? _device;
  BluetoothCharacteristic? _characteristic;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _startScan();
      },
      icon: const Icon(Icons.upload),
    );
  }

  void _startScan() {
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 4),
      androidUsesFineLocation: true,
    );

    FlutterBluePlus.onScanResults.listen(
      (results) {
        for (ScanResult r in results) {
          if (r.device.remoteId.str == "FC:B4:67:F6:1B:78") {
            FlutterBluePlus.stopScan();
            _connectToDevice(context, r.device);
            break;
          }
        }
      },
      onError: (e) => debugPrint(e),
    );
  }

  void _connectToDevice(BuildContext context, BluetoothDevice device) async {
    await device.connect();
    _device = device;

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connected to ESP32')),
    );

    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          _characteristic = characteristic;
        }
      }
    }

    final jwt = await ref.read(jwtRepositoryProvider).readJwt();
    if (jwt != null) {
      _sendConfig(jwt);
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No JWT found')),
      );
    }

    _device?.disconnect();
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
}
