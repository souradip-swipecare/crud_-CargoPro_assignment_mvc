import 'package:assignmettask/controllers/object_controller.dart';
import 'package:assignmettask/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/api_object.dart';

class ObjectDetailView extends StatelessWidget {
  final controller = Get.find<ObjectController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final obj = controller.selectedObject.value;

      if (obj == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(obj.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Get.toNamed(Routes.OBJECT_FORM, arguments: obj),
            ),
            Obx(() {
  return IconButton(
    icon: controller.deleteLoading.value
        ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.delete, color: Colors.red),

    onPressed: controller.deleteLoading.value
        ? null
        : () async {
            bool ok = await controller.deleteObj(obj.id!);
            if (ok) Get.offAllNamed("/home");
          },
  );
})

            ],
        ),

        body: LayoutBuilder(builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600; // Web/tablet responsive

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),

              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _details(obj)),
                        const SizedBox(width: 20),
                       
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _details(obj),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
            ),
          );
        }),
      );
    });
  }

  Widget _details(ApiObject obj) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(obj.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26)),

        const SizedBox(height: 20),

        ...obj.data!.entries.map(
          (e) => Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEAE2F2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.key,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Text(e.value.toString(),
                    style: const TextStyle(
                        fontSize: 16, color: Colors.black54)),
              ],
            ),
          ),
        )
      ],
    );
  }

  }

// class ObjectDetailView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ApiObject obj = Get.arguments;
//     final controller = Get.find<ObjectController>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(obj.name),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () =>
//                 Get.toNamed(Routes.OBJECT_FORM, arguments: obj),
//           ),
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () async {
//               final confirm = await Get.dialog(
//                 AlertDialog(
//                   title: Text("Delete?"),
//                   content: Text("Are you sure you want to delete?"),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Get.back(result: false),
//                       child: Text("Cancel"),
//                     ),
//                     TextButton(
//                       onPressed: () => Get.back(result: true),
//                       child: Text("Delete"),
//                     ),
//                   ],
//                 ),
//               );

//               if (confirm) {
//                 await controller.deleteObj(obj.id!);
//                 Get.back(); // go back to list
//               }
//             },
//           ),
//         ],
//       ),

//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(obj.name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 12),
//                 Text("Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Divider(),
//                 ...obj.data!.entries.map((e) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(e.key, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                         Text(e.value.toString(), style: TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
