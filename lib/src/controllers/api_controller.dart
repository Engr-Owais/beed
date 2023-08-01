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

  void setOffset(int offsetVal) {
    offset.value = offsetVal + 10;
  }

  @override
  void onInit() {
    super.onInit();

    loadDataFromApi();

    handleNext();
  }

  void loadDataFromHive() async {
    try {
      final box = await Hive.openBox<Result>('results');
      if (result.length == 0) {
        offset.value = await box.values.length;
        result.addAll(box.values.toList());
      }
    } catch (e) {
      print('Error loading data from Hive: $e');
    }
  }

  Future<void> loadDataFromApi() async {
    try {
      isInternetConnected.value = await Utils.checkInternetConnectivity();
      if (isInternetConnected.isTrue) {
        loading.value = true;

        var response = await ApiService.fetchAPIData(offset: offset.value);

        result = result + response.results;

        loading.value = false;
        setOffset(offset.value);

        // Save new data to Hive
        await SaveNewDataHive();
      } else {
        loadDataFromHive();
      }
    } catch (e) {
      print('Error loading data from API: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> SaveNewDataHive() async {
    final box = await Hive.openBox<Result>('results');

    await box.clear();
    await box.addAll(result);
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        loadDataFromApi();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
