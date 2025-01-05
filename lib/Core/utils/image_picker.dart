import 'package:image_picker/image_picker.dart';
import 'package:pro_icon/Core/errors/failures.dart';

class ImagePickerHelper {
  late final ImagePicker _imagePicker;

  ImagePickerHelper() {
    _imagePicker = ImagePicker();
  }

  Future<XFile?> pickImage() async {
    XFile? image;
    try {
      image = await _imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      throw const ImagePickerFailure(message: "Failed to pick image");
    }
    return image;
  }
}
