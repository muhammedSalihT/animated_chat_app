import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class FlashProvider extends ChangeNotifier {
  final List<String> items = List.filled(15, 'Obvio');
  int currentBarIndex = 1;
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  void onForword() {
    if (carouselSliderController.ready) {
      if (currentBarIndex < items.length) {
        currentBarIndex == currentBarIndex++;
        carouselSliderController.nextPage();
      }

      notifyListeners();
    }
  }

  void onbackWord() {
    if (carouselSliderController.ready) {
      if (currentBarIndex != 1) {
        currentBarIndex == currentBarIndex--;
        carouselSliderController.previousPage();
      }
      notifyListeners();
    }
  }
}
