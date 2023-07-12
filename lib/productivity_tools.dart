import 'package:flutter/material.dart';
import 'package:productivityapp/models/productivity.dart';

class ProductivityTools {
  List<Productivity> productivityList = [];

  List<Productivity> getProductivityList() {
    return productivityList;
  }

  addToProductivityList(Productivity item) {
    productivityList.add(item);
  }

  removeFromProductivityList(Productivity item) {
    productivityList.remove(item);
  }
}
