import 'dart:typed_data';

class FriendsModel {
  late String name;
  late String text;
  late String date;
  late String imageURL;
  late String messageType;
  late int messageCount;
  late String selectedIcons;
  late String reactionPanel;
  Uint8List? imageS3;
  bool? image;
  bool visibility;

  FriendsModel(
      {required this.name,
      required this.text,
      required this.date,
      required this.imageURL,
      required this.messageCount,
      required this.messageType,
      required this.selectedIcons,
      required this.reactionPanel,
      this.imageS3,
      this.image,
      required this.visibility,
      });
}
