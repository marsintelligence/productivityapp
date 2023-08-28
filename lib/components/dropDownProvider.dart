import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivityapp/models/productivity.dart';

final dropdownNotifierProvider =
    StateNotifierProvider<DropdownNotifier, Categ>((ref) {
  return DropdownNotifier();
});

class DropdownNotifier extends StateNotifier<Categ> {
  DropdownNotifier() : super(Categ.work);
  void setSelected(Categ value) {
    state = value;
  }
}
