class ConversationsImages {
  late String name;
  late String messageText;
  late String imageURL;
  late bool isGroupChat;
  late String? groupImage;
  ConversationsImages(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.isGroupChat,
      this.groupImage});
}
