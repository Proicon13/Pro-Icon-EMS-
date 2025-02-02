class MadBluetoothModel {
  final List<int> muscleValues; // Muscle name -> Percentage

  final List<int> pulseWidthValues; // Muscle name -> Pulse Width
  final int frequency; // Stimulation frequency
  final int onTime; // On time duration
  final int offTime; // Off time duration
  final int ramp; // Ramp time
  // Stimulation mode

  MadBluetoothModel({
    required this.muscleValues,
    required this.pulseWidthValues,
    required this.frequency,
    required this.onTime,
    required this.offTime,
    required this.ramp,
  });

  /// This includes **muscle power values, pulse width values, and frequency**
  String formatDataForCharacteristic1() {
    // Ensure the lists are balanced (fill with zeros if needed)
    while (muscleValues.length < 10) muscleValues.add(0);
    while (pulseWidthValues.length < 10) muscleValues.add(0);

    // Combine values in order: Muscle Power + Pulse Width + Frequency
    List<int> formattedValues = [...muscleValues, ...muscleValues, frequency];

    return formattedValues.join(",");
  }

  /// This includes **on-time, off-time, ramp, and mode**
  String formatDataForCharacteristic2() {
    return "$onTime,$offTime,$ramp,0";
  }

  /// 📤 Format Stop Signal to **Bluetooth Characteristic 1**
  /// Sends **21 values where first 20 are `0` and last is `1`**
  static String formatStopSignal() {
    List<int> stopSignal = List.filled(20, 0);
    stopSignal.add(1);
    return stopSignal.join(",");
  }
}
