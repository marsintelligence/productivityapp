import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivityapp/components/productivity_tile.dart';
import 'package:productivityapp/components/showDialog.dart';
import 'package:productivityapp/main.dart';
import 'package:productivityapp/productivityToolsProvider.dart';
import 'package:productivityapp/productivity_tools.dart';
import 'package:productivityapp/models/productivity.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'components/dropDownProvider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskNameController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();

  TextEditingController endTimeController = TextEditingController();

  TextEditingController durationController = TextEditingController();

  TextEditingController typeController = TextEditingController();

  List<Categ> typeList = Categ.values;

  Categ selectedType = Categ.routine;
  TimeOfDay chosenStartTime = TimeOfDay.now();
  TimeOfDay chosenEndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final screensizeWidth = MediaQuery.of(context).size.width;
    final screensizeHeight = MediaQuery.of(context).size.height;

    /*Productivity fakeTask = Productivity(
        taskName: "food",
        startTime: uTimeOfDay.now(),
        endTime: TimeOfDay.now(),
        duration: 30,
        type: Categ.work);
    productivityProv.addToProductivityList(fakeTask);*/
    return Consumer<ProductivityTools>(builder: (context, ref, child) {
      /* final productivityTools = ref.watch(productivityNotifierProvider);
      final readproductivityTools = ref.read(productivityNotifierProvider);*/
      /* final productivityProvider = ChangeNotifierProvider<ProductivityTools>(
          (ref) => ProductivityTools());
      final selectedstartTime = ref.watch(selectedStartTimeProvider);
      final selectedendTime = ref.watch(selectedEndTimeProvider);
      final selectedTypeCateg = ref.watch(dropdownNotifierProvider);*/
      final selectedCateg = Categ.work;
      addNewTask() {
        return showDialog(
            context: context,
            builder: (context) {
              return ShowDialog();
            });
      }

      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: addNewTask),
        body: ref.productivityList.isEmpty
            ? Center(
                child: Text('You do not have any items'),
              )
            : Container(
                height: screensizeHeight,
                width: screensizeWidth,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ref.productivityList.length,
                  itemBuilder: (context, index) {
                    var productivityTools = ref.productivityList;
                    //print(productivityProv.getProductivityList().length);
                    return ProductivityTile(
                        taskName: productivityTools[index].taskName,
                        duration: productivityTools[index].duration,
                        startTime: productivityTools[index].startTime,
                        endTime: productivityTools[index].endTime,
                        type: productivityTools[index].type);
                  },
                )),
      );
    });
  }

  Future<dynamic> showDialogFunction(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return ShowDialog();
        });
  }
}
