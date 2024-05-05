import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  String selectedCountry = 'USA'; // Default country
  String flagImageUrl = ''; // URL for the flag image

  void setSelectedCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setFlagImageUrl(String url) {
    flagImageUrl = url;
    notifyListeners();
  }
}
