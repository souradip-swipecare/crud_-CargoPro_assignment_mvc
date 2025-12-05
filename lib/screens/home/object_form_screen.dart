import 'dart:convert';
import 'package:assignmettask/controllers/object_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/api_object.dart';

class ObjectFormView extends StatefulWidget {
  @override
  State<ObjectFormView> createState() => _ObjectFormViewState();
}

class _ObjectFormViewState extends State<ObjectFormView> {
  final nameCtrl = TextEditingController();
  List<MapEntry<String, dynamic>> fields = [];

  @override
  void initState() {
    super.initState();
    final ApiObject? obj = Get.arguments;

    if (obj != null) {
      nameCtrl.text = obj.name;
      fields = obj.data?.entries.toList() ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ObjectController>();
    final ApiObject? obj = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(obj == null ? "Add Object" : "Update Object"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      backgroundColor: const Color(0xFFF8F8F8),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() => fields.add(const MapEntry("", "")));
        },
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _inputCard(
            child: TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Object Name",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Data Fields",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ...List.generate(fields.length, (i) {
            return _inputCard(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Key",
                        border: InputBorder.none,
                      ),
                      onChanged: (v) =>
                          fields[i] = MapEntry(v, fields[i].value),
                      controller: TextEditingController(text: fields[i].key),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Value",
                        border: InputBorder.none,
                      ),
                      onChanged: (v) => fields[i] = MapEntry(fields[i].key, v),
                      controller: TextEditingController(
                        text: "${fields[i].value}",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() => fields.removeAt(i));
                    },
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 30),

          Obx(() {
  final isCreate = obj == null;
  final bool isLoading = 
      isCreate ? controller.createLoading.value 
               : controller.updateLoading.value;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),

    onPressed: isLoading
        ? null // disable button during loading
        : () async {
            final data = {
              for (var f in fields)
                if (f.key.trim().isNotEmpty) f.key: f.value,
            };

            final newObj = ApiObject(
              id: obj?.id,
              name: nameCtrl.text.trim(),
              data: data,
            );

            bool ok;
            if (isCreate) {
              ok = await controller.create(newObj);
            } else {
              ok = await controller.updateobj(newObj);
            }

            if (ok) {
              Get.offAndToNamed("/home");
            }
        },

    child: isLoading
        ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Text(isCreate ? "Create Object" : "Update Object"),
  );
})

        ],
      ),
    );
  }

  Widget _inputCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
