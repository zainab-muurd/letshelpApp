class MyProductReq{


  int requestId ;
  String requestText;
  String requestClient;
  String requestClientPhone;
  String requestClientImage;
  int requestStatus;

  MyProductReq({
    required this.requestId ,
    required this.requestText,
    required this.requestClient,
    required this.requestClientPhone,
    required this.requestClientImage,
    required this.requestStatus
});
}