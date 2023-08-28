import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivityapp/components/productivity_tile.dart';
import 'package:productivityapp/main.dart';
import 'package:productivityapp/productivityToolsProvider.dart';
import 'package:productivityapp/productivity_tools.dart';
import 'package:productivityapp/models/productivity.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//import 'components/dropDownProvider.dart';

class ShowDialog extends StatefulWidget {
  final int? index;

  const ShowDialog({super.key, this.index});

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  TimeOfDay chosenStartTime = TimeOfDay.now();

  TimeOfDay chosenEndTime = TimeOfDay.now();
  TextEditingController taskNameController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();

  TextEditingController endTimeController = TextEditingController();

  TextEditingController durationController = TextEditingController();

  TextEditingController typeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Categ> typeList = Categ.values;

  Categ selectedType = Categ.work;

  DateTime chosenDate = DateTime.now();
  //int workDuration = 0;
  // int entDuration = 0;

  @override
  void dispose() {
    taskNameController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    durationController.dispose();
    typeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index != null) {
      if (widget.index! < 8) {
        chosenStartTime = TimeOfDay(hour: 0, minute: 0);

        chosenEndTime = TimeOfDay(hour: 8, minute: 0);
      }

      chosenStartTime = TimeOfDay(hour: widget.index!, minute: 0);

      chosenEndTime = TimeOfDay(hour: widget.index! + 1, minute: 0);
    }
    final screensizeWidth = MediaQuery.of(context).size.width;
    final screensizeHeight = MediaQuery.of(context).size.height;
    /*dateController.text = DateFormat('dd/MM/yy').format(chosenDate);
    endTimeController.text = '${chosenEndTime.hour}:${chosenEndTime.minute}';
    startTimeController.text =
        '${chosenStartTime.hour}:${chosenStartTime.minute}';
    durationController.text = '0';
    taskNameController.text = "New Task";*/

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

      return SingleChildScrollView(
        child: AlertDialog(
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
                  controller: dateController,
                  decoration: InputDecoration(label: Text('Date')),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050));
                    if (pickedDate != null) {
                      setState(() {
                        chosenDate = pickedDate;
                      });
                    }
                    String formattedDate =
                        DateFormat('dd/MM/yy').format(chosenDate);
                    dateController.text = formattedDate;
                  }),
              TextField(
                  controller: startTimeController,
                  decoration: InputDecoration(
                    label: Text('Start Time'),
                  ),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: chosenStartTime);

                    if (pickedTime != null) {
                      setState(() {
                        chosenStartTime = pickedTime;
                      });

                      String hour = chosenStartTime.hour.toString();
                      String minute = chosenStartTime.minute.toString();
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
                      initialTime: chosenEndTime,
                    );

                    if (pickedTime != null) {
                      setState(() {
                        chosenEndTime = pickedTime;
                      });

                      String hour = chosenEndTime.hour.toString();
                      String minute = chosenEndTime.minute.toString();
                      endTimeController.text = hour + ":" + minute;
                    }
                  }),
              TextField(
                controller: durationController,
                decoration: InputDecoration(
                  label: Text('Duration'),
                ),
              ),
              StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return DropdownButton<Categ>(
                    value: selectedType,
                    items: typeList
                        .map((type) => DropdownMenuItem<Categ>(
                            value: type, child: Text(type.toString())))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                  );
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
                // Categ type = selectedType;

                Productivity newTask = Productivity(
                  taskName: taskName,
                  startTime: chosenStartTime,
                  endTime: chosenEndTime,
                  duration: duration,
                  type: selectedType,
                  date: chosenDate,
                );
                Provider.of<ProductivityTools>(context, listen: false)
                    .addToProductivityList(newTask);
                /* if (selectedType == Categ.work) {
                  ref.workDuration[widget.index!] = duration;
                }
                if (selectedType == Categ.entertainment) {
                  ref.entDuration[widget.index!] = duration;
                }*/
                Provider.of<ProductivityTools>(context, listen: false)
                    .filterProductivityListByDate(chosenDate);

                // ref.refresh(productivityProv.productivityList);
                //print(productivityProv.getProductivityList().length);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    });
  }
}
