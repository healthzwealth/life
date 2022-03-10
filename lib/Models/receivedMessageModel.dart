class ReceivedMessageModel {
  late String name;
  late String text;
  late String date;
  late String imageURL;
  late String messageType;
  late int messageCount;
  ReceivedMessageModel(
      {
      required this.name,
      required this.text,
      required this.date,
      required this.imageURL,
      required this.messageCount,
      required this.messageType});
}