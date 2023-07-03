import 'package:productivityapp/models/productivity.dart';

class ProductivityTools {
  Productivity item = Productivity(
      taskName: 'Study',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      duration: 30,
      type: Categ.work);
  List<Productivity> productivityList = [];
  List<Productivity> getProductivityList() {
    return productivityList;
  }

  addToProductivityList() {
    productivityList.add(item);
  }

  removeFromProductivityList(Productivity item) {
    productivityList.remove(item);
  }
}
