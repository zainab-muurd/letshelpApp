class Order {
  int orderID;
  String title;
  String description;
  String country;
  String city;
  String address;
  String clientName;
  String clientImage;
  String category;
  String date;
  int? status;

  Order(
      {required this.orderID,
      required this.title,
      required this.description,
      required this.country,
      required this.city,
      required this.clientName,
      required this.clientImage,
      required this.address,
      required this.category,
      required this.date,
        this.status
      });
}
