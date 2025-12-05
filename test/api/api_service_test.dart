import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_api_service.dart';
import '../fixtures/fixture_reader.dart';
import 'dart:convert';

void main() {
  late MockApiService mockApi;

  setUp(() {
    mockApi = MockApiService();
  });
//bbfgb
  test("GET /objects returns list", () async {
    final mockResponse = json.decode(fixture("object_list.json"));

    when(mockApi.get("/objects"))
        .thenAnswer((_) async => mockResponse);

    final result = await mockApi.get("/objects");

    expect(result, isList);
    expect(result.first["id"], "1");
  });

  test("GET /objects/{id} returns one object", () async {
    final mockResponse = json.decode(fixture("object_single.json"));

    when(mockApi.get("/objects/1"))
        .thenAnswer((_) async => mockResponse);

    final result = await mockApi.get("/objects/1");

    expect(result["id"], "1");
    expect(result["name"], "Google Pixel 6 Pro");
  });

  test("POST /objects creates object", () async {
    final mockResponse = {"id": "10", "name": "New"};

    when(mockApi.post("/objects", any))
        .thenAnswer((_) async => mockResponse);

    final result = await mockApi.post("/objects", {"name": "New"});

    expect(result["id"], "10");
  });

  test("PUT /objects/{id} updates object", () async {
    final mockResponse = {"id": "1", "name": "Updated"};

    when(mockApi.put("/objects/1", any))
        .thenAnswer((_) async => mockResponse);

    final result = await mockApi.put("/objects/1", {"name": "Updated"});

    expect(result["name"], "Updated");
  });

  test("DELETE /objects/{id} deletes object", () async {
    when(mockApi.delete("/objects/1"))
        .thenAnswer((_) async => {"message": "deleted"});

    final result = await mockApi.delete("/objects/1");

    expect(result["message"], "deleted");
  });
}
