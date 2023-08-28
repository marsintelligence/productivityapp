import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivityapp/database_helper.dart';
import 'package:productivityapp/models/productivity.dart';

final databaseProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper.instance;
});

final productivityNotifierProvider =
    StateNotifierProvider<ProductivityToolsProvider, List<Productivity>>((ref) {
  return ProductivityToolsProvider();
});

class ProductivityToolsProvider extends StateNotifier<List<Productivity>> {
  ProductivityToolsProvider() : super([]);
  void addToProductivityList(Productivity item) {
    state = [...state, item];
  }

  void removeFromProductivityList(Productivity item) {
    state = state.where((element) => element != item).toList();
  }

  void clearList() {
    state = [];
  }
}
