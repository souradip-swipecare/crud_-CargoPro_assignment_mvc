import 'package:assignmettask/data/network/api_service.dart';
import 'package:assignmettask/exceptions/network_exceptions.dart';
import 'package:assignmettask/utils/error_handler.dart';
import 'package:assignmettask/utils/loading.dart';
import 'package:get/get.dart';
import '../../data/models/api_object.dart';

class ObjectController extends GetxController {
  final ApiService api;

  ObjectController(this.api);

  RxBool loading = false.obs;
  Rx<ApiObject?> selectedObject = Rx<ApiObject?>(null);
  RxList<ApiObject> objects = <ApiObject>[].obs;
RxBool createLoading = false.obs;
RxBool updateLoading = false.obs;
RxBool deleteLoading = false.obs;

  @override
  void onInit() {
    fetchObjects();
    super.onInit();
  }

  // FETCH LIST
  Future<void> fetchObjects() async {
    try {
      loading(true);

      final data = await api.get("/objects");
      objects.value = (data as List).map((e) => ApiObject.fromJson(e)).toList();
      
    } catch (e) {
      ErrorHandler.show(NetworkExceptions.handle(e));
    } finally {
      loading(false);
    }
  }

  // FETCH SINGLE (DETAIL SCREEN)
  Future<void> fetchObjectById(String id) async {
    try {
      LoadingOverlay.show();

      final data = await api.get("/objects/$id");
      selectedObject.value = ApiObject.fromJson(data);

    } catch (e) {
      ErrorHandler.show(NetworkExceptions.handle(e));
    } finally {
      LoadingOverlay.hide();
    }
  }

  // CREATE OBJECT
  Future<bool> create(ApiObject obj) async {
    try {
      createLoading(true);


      final res = await api.post("/objects", obj.toJson());
      objects.add(ApiObject.fromJson(res));
      objects.refresh();

      Get.snackbar("Success", "Object created successfully!");

      return true;  // success

    } catch (e) {
      ErrorHandler.show(NetworkExceptions.handle(e));
      return false;
    } finally {
      createLoading(false);

    }
  }

  // UPDATE OBJECT
  Future<bool> updateobj(ApiObject obj) async {
    try {
      updateLoading(true);


      final res = await api.put("/objects/${obj.id}", obj.toJson());

      int index = objects.indexWhere((x) => x.id == obj.id);
      objects[index] = ApiObject.fromJson(res);
      objects.refresh();

      Get.snackbar("Success", "Object updated!");

      return true;

    } catch (e) {
      updateLoading(false);

      ErrorHandler.show(NetworkExceptions.handle(e));
      return false;
    } finally {
      updateLoading(false);

    }
  }

  // DELETE OBJECT
  Future<bool> deleteObj(String id) async {
    try {
      deleteLoading(true);


      await api.delete("/objects/$id");

      objects.removeWhere((x) => x.id == id);
      objects.refresh();

      Get.snackbar("Success", "Object deleted!");

      return true;

    } catch (e) {
      ErrorHandler.show(NetworkExceptions.handle(e));
      return false;
    } finally {
      deleteLoading(false);

    }
  }
}
