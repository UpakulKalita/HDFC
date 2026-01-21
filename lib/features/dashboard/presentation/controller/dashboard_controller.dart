import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  /// Sidebar menu titles (for reference / UI binding)
  final List<String> menuItems = [
    "Health Plans",
    "Term Plans",
    "My Policies",
    "Get Help",
  ];

  /// Change selected menu
  void changeMenu(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }

  /// Reset to home
  void reset() {
    _selectedIndex = 0;
    notifyListeners();
  }
}
