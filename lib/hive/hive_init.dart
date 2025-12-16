import 'package:demo/models/expense_model.dart';
import 'package:demo/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  
  // Register Adapters
  // Check if adapter is already registered to avoid errors during hot restart
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ExpenseAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(UserAdapter());
  }

  // Open Boxes
  await Hive.openBox('settings');
  await Hive.openBox('cache');
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox('home_data'); // New box for Home Form Data
  await Hive.openBox<User>('user_list'); // Box for User List
}
