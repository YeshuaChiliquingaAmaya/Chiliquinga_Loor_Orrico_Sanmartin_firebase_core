// lib/views/categories_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/category_list_viewmodel.dart';
import '../viewmodels/category_products_viewmodel.dart';
import '../repositories/product_repository.dart';
import 'category_products_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryListViewModel = Provider.of<CategoryListViewModel>(context);
    final categories = categoryListViewModel.categories;

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 2,
          child: ListTile(
            leading: const Icon(Icons.folder_open),
            title: Text(category),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => CategoryProductsViewModel(
                      Provider.of<ProductRepository>(context, listen: false),
                      category,
                    ),
                    child: CategoryProductsPage(category: category),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
