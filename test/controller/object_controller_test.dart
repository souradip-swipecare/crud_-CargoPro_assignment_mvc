import 'package:flutter_test/flutter_test.dart';
import 'package:assignmettask/controllers/object_controller.dart';
import 'package:assignmettask/data/models/api_object.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_api_service.dart';
import '../fixtures/fixture_reader.dart';
import 'dart:convert';

void main() {
  late MockApiService mockApi;
  late ObjectController controller;

  setUp(() {
    mockApi = MockApiService();
    controller = ObjectController(mockApi);
  });

  test("fetchObjects loads list into controller", () async {
    final response = json.decode(fixture("object_list.json"));

    when(mockApi.get("/objects"))
        .thenAnswer((_) async => response);

    await controller.fetchObjects();

    expect(controller.objects.length, 3);
  });

  test("updateObject correctly updates list", () async {
    final obj = ApiObject(id: "1", name: "Old", data: {});
    controller.objects.assign(obj);

    final updated = {"id": "1", "name": "Updated", "data": {}};

    when(mockApi.put("/objects/1", any))
        .thenAnswer((_) async => updated);

    final result = await controller.updateobj(obj);

    expect(result, true);
    expect(controller.objects.first.name, "Updated");
  });

  test("deleteObject removes item from list", () async {
    final obj = ApiObject(id: "1", name: "Test", data: {});
    controller.objects.add(obj);

    when(mockApi.delete("/objects/1"))
        .thenAnswer((_) async => {"message": "deleted"});

    final result = await controller.deleteObj("1");

    expect(result, true);
    expect(controller.objects.isEmpty, true);
  });
}
