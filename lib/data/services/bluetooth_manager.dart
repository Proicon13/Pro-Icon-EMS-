import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothManager {
  Future<bool> _ensurePermissionsAndServices() async {
    final bool isBluetoothOn = await _checkBluetooth();
    if (!isBluetoothOn) return false;

    final bool isLocationEnabled = await _checkLocationPermissions();
    if (!isLocationEnabled) return false;

    return true;
  }

  Future<bool> _checkBluetooth() async {
    final BluetoothAdapterState adapterState =
        await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      await FlutterBluePlus.turnOn();
      await Future.delayed(const Duration(seconds: 2)); // Wait for activation

      final BluetoothAdapterState newState =
          await FlutterBluePlus.adapterState.first;
      if (newState != BluetoothAdapterState.on) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _checkLocationPermissions() async {
    if (!(await Permission.location.isGranted)) {
      await Permission.location.request();
      if (!(await Permission.location.isGranted)) {
        return false;
      }
    }

    // 🔹 Check if Location Services are enabled
    if (!(await Permission.location.serviceStatus.isEnabled)) {
      return false;
    }

    return true;
  }

  /// **🔍 Scan for Available Bluetooth Devices**

  Future<List<BluetoothDevice>> scanDevices() async {
    final Set<BluetoothDevice> discoveredDevices =
        {}; // Use a Set to avoid duplicates
    final Completer<List<BluetoothDevice>> scanCompleter = Completer();

    try {
      final bool canScan = await _ensurePermissionsAndServices();
      if (!canScan) {
        scanCompleter.complete([]);
        return scanCompleter.future;
      }
      // Start BLE Scan
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // Subscribe to scan results
      StreamSubscription<List<ScanResult>>? subscription;
      subscription = FlutterBluePlus.scanResults.listen((results) {
        for (var result in results) {
          if (result.device.remoteId.str.isNotEmpty) {
            discoveredDevices
                .add(result.device); // Automatically filters duplicates
          }
        }
      });

      // Wait for scan to complete
      await Future.delayed(const Duration(seconds: 5));

      // Stop scanning
      await FlutterBluePlus.stopScan();

      // Cancel subscription to avoid memory leaks
      await subscription.cancel();

      // Complete with final device list
      scanCompleter.complete(discoveredDevices.toList());
    } catch (e) {
      print("❌ Scan Error: $e");
      scanCompleter.completeError(e);
    }

    return scanCompleter.future;
  }

  /// **🔗 Connect to a Bluetooth Device**
  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// **🔌 Disconnect from a Bluetooth Device**
  Future<bool> disconnectFromDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// **📡 Send Data to a Single Device**
  Future<void> sendDataToDevice(BluetoothDevice device, String data) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.write) {
            await characteristic.write(data.codeUnits);
            print("Data Sent to Device ${device.platformName}: $data");
            return;
          }
        }
      }
    } catch (e) {
      print("Data Sending Error: $e");
      rethrow;
    }
  }

  /// **📡 Send Data to Multiple Devices**
  Future<void> sendDataToDevices(
      List<BluetoothDevice> devices, String data) async {
    for (var device in devices) {
      await sendDataToDevice(device, data);
    }
  }

  /// **🩺 Read Data from Device**
  Future<int> readData(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.read) {
            var value = await characteristic.read();
            return int.parse(String.fromCharCodes(value));
          }
        }
      }
      return 0;
    } catch (e) {
      print("Read Error: $e");
      return 0;
    }
  }
}
