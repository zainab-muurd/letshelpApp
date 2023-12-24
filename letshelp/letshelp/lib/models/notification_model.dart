class NotificationModel {


  int id;
  int? type;
  int? idOnPage;
  String text;
  bool isRead;


  NotificationModel({
    required this.id,
    required this.idOnPage,
  required this.text,
  required this.isRead,
    required this.type

});

  factory NotificationModel.FromJson (Map<String,dynamic> json) {
  return NotificationModel(
    id :json["id"],
    idOnPage :json ['idOnPage'],
    text : json ["text"],
    isRead : json ["isRead"],
    type :json["type"],
  );

  }

}