class SingleProduct {

int id ;
String title;
String description;
String mainImage ;
String clientName ;
String clientImage;
String category;
String country;
String city;
String address;
List<String>? images=[] ;

SingleProduct({
  required this.id,
  required this.title,
  required this.description,
  required this.mainImage,
  required this.clientName,
  required this.clientImage,
  required this.category,
  required this.country,
  required this.city,
  required this.address,
   this.images
});


}