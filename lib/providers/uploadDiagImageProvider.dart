import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:life_app/Models/UploadImageModel.dart';
import 'package:simple_s3/simple_s3.dart';

class UploadImageProvider with ChangeNotifier {
  Future<String> postDiagUploadImageS3(
      UploadImageModel uploadImageModel) async {
    print("Im called");

    SimpleS3 _simpleS3 = SimpleS3();
    final response = await _simpleS3.uploadFile(
      uploadImageModel.imageFile,
      'hzw.diag',
      'us-east-1:fd6b7435-a230-49fa-9ead-fb156204b720',
      AWSRegions.usEast1,
      debugLog: true,
      s3FolderPath: "public/uploads/1/987654/diag",
      accessControl: S3AccessControl.publicRead,
      fileName: uploadImageModel.fileNameS3,
    );
    print(response);
    final extractedData = response as dynamic;
    return extractedData;
  }

  Future<List<UploadImageModel>> getAllImages() async {
    print("Provider called");
    final AwsS3Client s3client = AwsS3Client(
        region: 'us-east-1',
        host: "s3.us-east-1.amazonaws.com",
        bucketId: 'hzw.diag',
        accessKey: "AKIAS4DJFFDCIE6342IV",
        secretKey: "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");
    List<UploadImageModel> images = [];
    try {
      print("Inside try");
      print(DateTime.now().toIso8601String());
      final listBucketResult = await s3client.listObjects(
          prefix: "public/uploads/1/987654/diag/", delimiter: "/");
      if (listBucketResult != null) {
        final extractedData = listBucketResult.contents!.toList();
        print(extractedData);
        var count = (listBucketResult.keyCount);
        print(count);
        for (int i = 0; i < int.parse(count!); i++) {
          var key = extractedData[i].key;
          final imageresponse = await s3client.getObject(key!);
          images.add(
            UploadImageModel(
              imageS3: imageresponse.bodyBytes,
            ),
          );
        }
      }
      print(DateTime.now().toIso8601String());
      print("Im the end of loop");
      // print(images.length);
    } catch (error) {
      print('*******');
      print(error);
    }
    return images;
  }
}
