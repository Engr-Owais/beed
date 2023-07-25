// // beer_list_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/beer_controller.dart';
// import '../data/models/beer_model.dart';
// class BeerListPage extends StatelessWidget {
//   final BeerController beerController = Get.put(BeerController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         if (beerController.isLoading.value && beerController.beerList.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return RefreshIndicator(
//             onRefresh: () => beerController.fetchBeers(isRefresh: true),
//             child: ListView.builder(
//               itemCount: beerController.beerList.length + 1,
//               itemBuilder: (context, index) {
//                 if (index < beerController.beerList.length) {
//                   final Beer beer = beerController.beerList[index];
//                   return ListTile(
//                     c
//                     title: Text(beer.name),
//                     subtitle: Text('ID: ${beer.id}'),
//                     // Add more UI elements as needed.
//                   );
//                 } else if (beerController.isLoading.value) {
//                   return Center(child: CircularProgressIndicator());
//                 } else {
//                   return Container(); // Add an empty container to avoid errors during scrolling.
//                 }
//               },
//               controller: ScrollController()
//                 ..addListener(() {
//                   if (ScrollController().position.pixels == ScrollController().position.maxScrollExtent) {
//                     beerController.fetchNextPage();
//                   }
//                 }),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
