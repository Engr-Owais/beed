import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../data/api.dart';
import '../data/models/result.dart';
import '../utils/connectivity_check.dart';

class ApiController extends GetxController {
  var result = <Result>[].obs;
  ScrollController scrollController = ScrollController();
  var loading = true.obs;
  var offset = 0.obs;
  var isInternetConnected = true.obs;

  @override
  void onInit() {
    super.onInit();

    loadDataFromApi(offset);
    handleNext();
  }

  void loadDataFromHive() async {
    try {
      final box = await Hive.openBox<Result>('results');
      box.clear();
      result.addAll(box.values.toList());
    } catch (e) {
      print('Error loading data from Hive: $e');
    }
  }

  Future<void> loadDataFromApi(currentOffset) async {
    try {
      isInternetConnected.value = await Utils.checkInternetConnectivity();
      if (isInternetConnected.isTrue) {
        loading.value = true;
        var response = await ApiService.fetchBeers(offset: currentOffset);

        result = result + response.results;
        int localOffset = offset.value + 10;

        loading.value = false;
        offset.value = localOffset;

        // Save new data to Hive

        final box = await Hive.openBox<Result>('results');

        box.clear();
        box.addAll(result);
      } else {
        loadDataFromHive();
      }
    } catch (e) {
      print('Error loading data from API: $e');
    } finally {
      loading.value = false;
    }
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        loadDataFromApi(offset.value);
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
