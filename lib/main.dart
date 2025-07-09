// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// Importar todos los servicios, repositorios, viewmodels y vistas
import 'services/auth_service.dart';
import 'services/firestore_service.dart';

import 'repositories/user_repository.dart';
import 'repositories/product_repository.dart';
import 'repositories/order_repository.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/product_list_viewmodel.dart';
import 'viewmodels/category_list_viewmodel.dart';
import 'viewmodels/category_products_viewmodel.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/my_orders_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'viewmodels/add_product_viewmodel.dart';

import 'views/auth_screen.dart';
import 'views/home_screen.dart';
import 'views/add_product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveer los servicios
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),

        // Proveer los repositorios (dependen de los servicios)
        Provider<UserRepository>(
          create: (context) => UserRepository(
            Provider.of<AuthService>(context, listen: false),
            Provider.of<FirestoreService>(context, listen: false),
          ),
        ),
        Provider<ProductRepository>(
          create: (context) => ProductRepository(
            Provider.of<FirestoreService>(context, listen: false),
          ),
        ),
        Provider<OrderRepository>(
          create: (context) => OrderRepository(
            Provider.of<FirestoreService>(context, listen: false),
            Provider.of<AuthService>(context, listen: false),
          ),
        ),

        // Proveer los ViewModels (dependen de los repositorios)
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<ProductListViewModel>(
          create: (context) => ProductListViewModel(
            Provider.of<ProductRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<CategoryListViewModel>(
          create: (_) => CategoryListViewModel(),
        ),
        ChangeNotifierProvider<CartViewModel>(
          create: (context) => CartViewModel(
            Provider.of<OrderRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<MyOrdersViewModel>(
          create: (context) => MyOrdersViewModel(
            Provider.of<OrderRepository>(context, listen: false),
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<AddProductViewModel>(
          create: (context) => AddProductViewModel(
            Provider.of<ProductRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Tienda de Productos Locales',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
        home: Consumer<HomeViewModel>(
          builder: (context, homeViewModel, child) {
            return StreamBuilder<User?>(
              stream: homeViewModel.currentUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User? user = snapshot.data;
                  if (user == null) {
                    return const AuthScreen();
                  } else {
                    return const HomeScreen();
                  }
                }
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}