class Either<E, T> {
  final T? data;
  final E? error;
  final bool isSuccess;

  Either.success({this.data})
      : error = null,
        isSuccess = true;
  Either.error({this.error})
      : data = null,
        isSuccess = false;
}

/// TO MANAGE API RESPONSE ERROR
class ResponseError {
  final String message;
  ResponseError(this.message);

  factory ResponseError.fromJson(Map<String, dynamic> json) {
    return ResponseError(json["message"]);
  }
  Map<String, dynamic> toJson() => {"message": message};
}

/// TO MANAGE API RESPONSE SUCCESS
class ResponseSuccess<T> {
  ResponseSuccess({
    required this.count,
    required this.results,
    required this.message,
    required this.token,
  });

  final int? count;
  final T results;
  final String? message;
  final String? token;

  factory ResponseSuccess.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ResponseSuccess(
      count: json["count"],
      results: json["result"] == null
          ? (T is List ? [] as T : null as T)
          : fromJsonT(json["result"]),
      message: json["message"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "result": results is List
            ? (results as List).map((x) => (x as dynamic).toJson()).toList()
            : (results as dynamic).toJson(),
        "message": message,
        "token": token,
      };
}
