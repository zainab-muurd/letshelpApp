

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../constant.dart';

class ImagesToUpload with ChangeNotifier {
  void setImages(List<XFile> imgs) {
    imgsForUpload = imgs;
  }

  List get getImagesForUpload {
    return  imgsForUpload!;
  }
}
