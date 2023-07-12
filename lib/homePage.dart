import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivityapp/components/productivity_tile.dart';
import 'package:productivityapp/main.dart';
import 'package:productivityapp/productivity_tools.dart';
import 'package:productivityapp/models/productivity.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  List<Categ> typeList = Categ.values;
  Categ selectedType = Categ.work;

  /*submitForm() {
    String taskName = taskNameController.text;
    DateTime startTime = DateTime.parse(startTimeController.text);
    DateTime endTime = DateTime.parse(endTimeController.text);
    int duration = int.parse(durationController.text);
    Categ type = selectedType;

    Productivity newTask = Productivity(
        taskName: taskName,
        startTime: startTime,
        endTime: endTime,
        duration: duration,
        type: type);
  }*/

  @override
  Widget build(BuildContext context) {
    final productivityProv = ref.watch(productivityProvider);
    final selectedstartTime = ref.watch(selectedStartTimeProvider);
    final selectedendTime = ref.watch(selectedEndTimeProvider);
    addNewTask() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Add new task"),
              content: Column(
                children: [
                  TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      label: Text('Task Name'),
                    ),
                  ),
                  TextField(
                      controller: startTimeController,
                      decoration: InputDecoration(
                        label: Text('Start Time'),
                      ),
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: ref.read(selectedStartTimeProvider),
                        );

                        if (pickedTime != null) {
                          ref.read(selectedStartTimeProvider.state).state =
                              pickedTime;
                          String hour = pickedTime.hour.toString();
                          String minute = pickedTime.minute.toString();
                          startTimeController.text = hour + ":" + minute;
                        }
                      }),
                  TextField(
                      controller: endTimeController,
                      decoration: InputDecoration(
                        label: Text('End Time'),
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: ref.read(selectedEndTimeProvider));

                        if (pickedTime != null) {
                          ref.read(selectedEndTimeProvider.state).state =
                              pickedTime;
                          String hour = pickedTime.hour.toString();
                          String minute = pickedTime.minute.toString();
                          endTimeController.text = hour + ":" + minute;
                        }
                      }),
                  TextField(
                    controller: durationController,
                    decoration: InputDecoration(
                      label: Text('Duration'),
                    ),
                  ),
                  DropdownButton(
                    value: ref.read(selectedDropDownProvider),
                    items: typeList
                        .map((value) => DropdownMenuItem(
                            value: value, child: Text(value.toString())))
                        .toList(),
                    onChanged: (newValue) {
                      ref.read(selectedDropDownProvider.state).state =
                          newValue!;
                    },
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  child: Text('Save'),
                  onPressed: () {
                    String taskName = taskNameController.text;

                    int duration = int.parse(durationController.text);
                    Categ type = selectedType;

                    Productivity newTask = Productivity(
                        taskName: taskName,
                        startTime: ref.read(selectedStartTimeProvider),
                        endTime: ref.read(selectedEndTimeProvider),
                        duration: duration,
                        type: ref.read(selectedDropDownProvider));
                    productivityProv.addToProductivityList(newTask);
                    print(productivityProv.getProductivityList().length);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    //final productivityProv = ref.watch(productivityProvider);
    Productivity fakeTask = Productivity(
        taskName: "food",
        startTime: TimeOfDay.now(),
        endTime: TimeOfDay.now(),
        duration: 30,
        type: Categ.work);
    productivityProv.addToProductivityList(fakeTask);
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: addNewTask),
        body: Column(
          children: <Widget>[
            Text('I am here'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: productivityProv.getProductivityList().length,
              itemBuilder: (context, index) {
                //print(productivityProv.getProductivityList().length);
                return ProductivityTile(
                    taskName:
                        productivityProv.getProductivityList()[index].taskName,
                    duration:
                        productivityProv.getProductivityList()[index].duration,
                    startTime:
                        productivityProv.getProductivityList()[index].startTime,
                    endTime:
                        productivityProv.getProductivityList()[index].endTime,
                    type: productivityProv.getProductivityList()[index].type);
              },
            ),
          ],
        ));
  }
}
