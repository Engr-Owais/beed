import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../data/api.dart';
import '../data/models/beer_model.dart';

class HomeController extends GetxController {
  var beers = <BeerModel>[].obs;
  var isLoading = false.obs;
  var currentPage = 1;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadDataFromHive();
    loadDataFromApi();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadDataFromApi();
      }
    });
  }

  void loadDataFromHive() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final isConnected = connectivityResult != ConnectivityResult.none;
      if (!isConnected) {
       

        final box = await Hive.openBox<BeerModel>('beers');
        beers.addAll(box.values.toList());
      }
    } catch (e) {
      print('Error loading data from Hive: $e');
    }
  }

  Future<void> loadDataFromApi() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final isConnected = connectivityResult != ConnectivityResult.none;
      if (isConnected) {
        isLoading.value = true;
        final newBeers =
            await ApiService.fetchBeers(page: currentPage, perPage: 10);
        if (newBeers.isNotEmpty) {
          currentPage++;
          beers.addAll(newBeers);
          // Save new data to Hive
          final box = await Hive.openBox<BeerModel>('beers');
          box.addAll(newBeers);
        }
      }
    } catch (e) {
      print('Error loading data from API: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
