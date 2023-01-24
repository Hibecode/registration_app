class Responses {
  String status;
  String message;
  String data;

  Responses({required this.status, required this.message, required this.data, });

  // now create converter

  factory Responses.fromJson(Map<String,dynamic> responseData){
    return Responses(
      status: responseData['status'] as String,
      message: responseData['message'] as String,
      data : responseData['data'] as String,
    );
  }
}