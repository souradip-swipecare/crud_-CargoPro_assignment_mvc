import 'package:assignmettask/controllers/object_controller.dart';
import 'package:assignmettask/routes/approutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class ObjectListView extends StatelessWidget {
  final controller = Get.find<ObjectController>();

  final List<Color> softColors = const [
    Color(0xFFEAE2F2),
    Color(0xFFE4EBF7),
    Color(0xFFF7F0D8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Objects", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.toNamed(Routes.OBJECT_FORM),
          ),
           IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF8F8F8),

      body: Obx(() {
        if (controller.loading.value) {
          return _loadingShimmer();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.objects.length,
          itemBuilder: (_, i) {
            final obj = controller.objects[i];
            final color = softColors[i % softColors.length];

            return GestureDetector(
              onTap: () async {
  await controller.fetchObjectById(obj.id!);
  Get.toNamed(Routes.OBJECT_DETAIL);
},
              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    // LEFT SIDE
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            obj.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C1C1E),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "ID: ${obj.id}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6E6E73),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // RIGHT ILLUSTRATION (PLACEHOLDER)
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/3209/3209265.png",
                        fit: BoxFit.contain,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // SHIMMER
  Widget _loadingShimmer() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, i) => Container(
        margin: const EdgeInsets.only(bottom: 18),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}


// class ObjectListView extends StatelessWidget {
//   final controller = Get.find<ObjectController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Objects List"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () => Get.toNamed(Routes.OBJECT_FORM),
//           ),
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => FirebaseAuth.instance.signOut(),
//           ),
//         ],
//       ),

//       body: Obx(() {
//         if (controller.loading.value) {
//           return _shimmerList();
//         }

//         return RefreshIndicator(
//           onRefresh: () => controller.fetchObjects(),
//           child: ListView.builder(
//             padding: EdgeInsets.all(12),
//             itemCount: controller.objects.length,
//             itemBuilder: (_, i) {
//               final obj = controller.objects[i];

//               return GestureDetector(
//                 onTap: () =>
//                     Get.toNamed(Routes.OBJECT_DETAIL, arguments: obj),
//                 child: Card(
//                   elevation: 3,
//                   margin: EdgeInsets.only(bottom: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: ListTile(
//                     title: Text(
//                       obj.name,
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       obj.data?.entries
//                               .map((e) => "${e.key}: ${e.value}")
//                               .join(" | ") ??
//                           "No Data",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//     );
//   }
// Widget _shimmerList() {
//   return ListView.builder(
//     padding: const EdgeInsets.all(12),
//     itemCount: 6,
//     itemBuilder: (_, __) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         child: Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           child: const ListTile(
//             title: SizedBox(
//               height: 20,
//               width: double.infinity,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(color: Colors.white),
//               ),
//             ),
//             subtitle: SizedBox(
//               height: 14,
//               width: double.infinity,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// }
