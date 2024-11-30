class Error {
  String status;
  String code;
  String message;

  Error({
    required this.status,
    required this.code,
    required this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      status: json['status'],
      code: json['code'],
      message: json['message'],
    );
  }
}
