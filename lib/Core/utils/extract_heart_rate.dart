int? extractHeartRate(String data) {
  try {
    // Convert string to bytes
    List<int> bytes = data.codeUnits;

    if (bytes.isEmpty) return null;

    int flags = bytes[0]; // First byte is the flags
    bool is16Bit = (flags & 0x01) != 0; // Check if heart rate is 16-bit

    int heartRate;
    if (is16Bit && bytes.length >= 3) {
      heartRate =
          (bytes[2] << 8) | bytes[1]; // Combine two bytes into a 16-bit value
    } else if (bytes.length >= 2) {
      heartRate = bytes[1]; // 8-bit value
    } else {
      return null;
    }

    return heartRate;
  } catch (e) {
    print("❌ Error extracting heart rate: $e");
    return null;
  }
}
