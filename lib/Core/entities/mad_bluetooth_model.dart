class MadBluetoothModel {
  final Map<String, int> muscleValues; // Muscle name -> Percentage
  final Map<String, int> pulseWidthValues; // Muscle name -> Pulse Width
  final int frequency; // Stimulation frequency
  final int onTime; // On time duration
  final int offTime; // Off time duration
  final int ramp; // Ramp time
  final int mode; // Stimulation mode

  MadBluetoothModel({
    required this.muscleValues,
    required this.pulseWidthValues,
    required this.frequency,
    required this.onTime,
    required this.offTime,
    required this.ramp,
    required this.mode,
  });

  /// This includes **muscle power values, pulse width values, and frequency**
  String formatDataForCharacteristic1() {
    List<int> powerValues = muscleValues.values.toList();
    List<int> widthValues = pulseWidthValues.values.toList();

    // Ensure the lists are balanced (fill with zeros if needed)
    while (powerValues.length < 10) powerValues.add(0);
    while (widthValues.length < 10) widthValues.add(0);

    // Combine values in order: Muscle Power + Pulse Width + Frequency
    List<int> formattedValues = [...powerValues, ...widthValues, frequency];

    return formattedValues.join(",");
  }

  /// This includes **on-time, off-time, ramp, and mode**
  String formatDataForCharacteristic2() {
    return "$onTime,$offTime,$ramp,$mode";
  }

  /// 📤 Format Stop Signal to **Bluetooth Characteristic 1**
  /// Sends **21 values where first 20 are `0` and last is `1`**
  String formatStopSignal() {
    List<int> stopSignal = List.filled(20, 0);
    stopSignal.add(1);
    return stopSignal.join(",");
  }
}
