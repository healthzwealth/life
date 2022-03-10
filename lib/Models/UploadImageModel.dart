import 'dart:io';

import 'dart:typed_data' show Uint8List;

class UploadImageModel {
  late File imageFile;
  late String fileNameS3;
  Uint8List? imageS3;

  UploadImageModel({this.imageS3});
}
