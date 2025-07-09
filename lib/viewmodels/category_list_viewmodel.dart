// lib/viewmodels/category_list_viewmodel.dart
import 'package:flutter/material.dart';

class CategoryListViewModel extends ChangeNotifier {
  List<String> get categories => ['Frutas y Verduras', 'Panadería', 'Artesanía', 'Textiles', 'Otros'];
}
