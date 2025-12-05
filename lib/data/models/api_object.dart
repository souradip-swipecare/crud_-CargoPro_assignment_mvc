class ApiObject {
  final String? id;
  final String name;
  final Map<String, dynamic>? data;

  ApiObject({
    this.id,
    required this.name,
    this.data,
  });

  factory ApiObject.fromJson(Map<String, dynamic> json) {
    return ApiObject(
      id: json["id"],
      name: json["name"],
      data: json["data"] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "data": data,
    };
  }
}
