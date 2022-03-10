import 'dart:typed_data';

class FriendsModel {
  late String name;
  late String text;
  late String date;
  late String imageURL;
  late String messageType;
  late int messageCount;
  Uint8List? imageS3;
  bool? image;

  FriendsModel({
    required this.name,
    required this.text,
    required this.date,
    required this.imageURL,
    required this.messageCount,
    required this.messageType,
    this.imageS3,
    this.image,
  });
}
