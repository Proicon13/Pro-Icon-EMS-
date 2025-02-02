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
      await Future.delayed(
          const Duration(seconds: 2)); // Allow time for activation

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

    if (!(await Permission.location.serviceStatus.isEnabled)) {
      return false;
    }

    return true;
  }

  Future<List<BluetoothDevice>> scanDevices({int scanDuration = 5}) async {
    final Set<BluetoothDevice> discoveredDevices = {};
    final Completer<List<BluetoothDevice>> scanCompleter = Completer();

    try {
      final bool canScan = await _ensurePermissionsAndServices();
      if (!canScan) {
        scanCompleter.complete([]);
        return scanCompleter.future;
      }

      // Start BLE Scan
      await FlutterBluePlus.startScan(timeout: Duration(seconds: scanDuration));

      // Subscribe to scan results
      StreamSubscription<List<ScanResult>>? subscription;
      subscription = FlutterBluePlus.scanResults.listen((results) {
        for (var result in results) {
          if (result.device.remoteId.str.isNotEmpty) {
            discoveredDevices.add(result.device);
          }
        }
      });

      // Wait for scan to complete
      await Future.delayed(Duration(seconds: scanDuration));

      // Stop scanning and cancel the subscription
      await FlutterBluePlus.stopScan();
      await subscription.cancel();

      // Return list of found devices
      scanCompleter.complete(discoveredDevices.toList());
    } catch (e) {
      print("❌ Scan Error: $e");
      scanCompleter.completeError(e);
    }

    return scanCompleter.future;
  }

  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        print("⚠️ Already connected to: ${device.platformName}");
        return true;
      }

      await device.connect();
      print("✅ Connected to: ${device.platformName}");
      return true;
    } catch (e) {
      print("❌ Connection Failed: $e");
      return false;
    }
  }

  Future<bool> disconnectFromDevice(BluetoothDevice device) async {
    try {
      if (!device.isConnected) {
        print("⚠️ Device already disconnected: ${device.platformName}");
        return true;
      }

      await device.disconnect();
      print("✅ Disconnected from: ${device.platformName}");
      return true;
    } catch (e) {
      print("❌ Disconnection Error: $e");
      return false;
    }
  }

  Future<void> sendDataToDevice(
      BluetoothDevice device, String data, String characteristicUuid) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.str == characteristicUuid &&
              characteristic.properties.write) {
            await characteristic.write(data.codeUnits);
            print("📤 Data Sent to ${device.platformName}: $data");
            return;
          }
        }
      }
      print(
          "❌ No writable characteristic found on device: ${device.platformName}");
    } catch (e) {
      print("❌ Data Sending Error: $e");
      rethrow;
    }
  }

  Future<void> sendDataToDevices(List<BluetoothDevice> devices, String data,
      String characteristicUuid) async {
    for (var device in devices) {
      await sendDataToDevice(device, data, characteristicUuid);
    }
  }

  Future<String> readDataFromDevice(
      BluetoothDevice device, String characteristicUuid) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.str == characteristicUuid &&
              characteristic.properties.read) {
            var value = await characteristic.read();
            return String.fromCharCodes(value);
          }
        }
      }
      print(
          "❌ No readable characteristic found on device: ${device.platformName}");
      return "";
    } catch (e) {
      print("❌ Read Error: $e");
      return "";
    }
  }

  void handleDisconnection(BluetoothDevice device) {
    device.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.disconnected) {
        print(
            "⚠️ Device Disconnected: ${device.platformName}. Attempting reconnect...");
        while (!device.isConnected) {
          bool success = await connectToDevice(device);
          if (success) {
            print("✅ Reconnected to: ${device.platformName}");
            break;
          }
          await Future.delayed(const Duration(seconds: 5));
        }
      }
    });
  }

  void dispose() {
    FlutterBluePlus.stopScan();
  }
}
