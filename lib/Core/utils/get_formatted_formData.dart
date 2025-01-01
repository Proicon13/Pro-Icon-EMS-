import '../../data/models/city_model.dart';

Map<String, dynamic> getFormattedFormData(
    Map<String, dynamic> formData, String fullPhoneNumber) {
  {
    final updatedFormData = formData.map((key, value) {
      switch (key) {
        case 'phone':
          return MapEntry(key, fullPhoneNumber);
        case 'city':
          return MapEntry("cityId", (value as CityModel).id.toString());
        case 'fullName':
          return MapEntry("fullname", (value as String).trim());
        case 'fullAddress':
          return MapEntry("address", (value as String).trim());
        default:
          return MapEntry(key, value);
      }
    });

    return updatedFormData;
  }
}
