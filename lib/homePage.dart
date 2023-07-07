import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivityapp/components/productivity_tile.dart';
import 'package:productivityapp/main.dart';
import 'package:productivityapp/productivity_tools.dart';
import 'package:productivityapp/models/productivity.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  Categ selectedType = Categ.work;
  submitForm(){
    String taskName=taskNameController.text;
    DateTime startTime=DateTime.parse(startTimeController.text);
    DateTime endTime=DateTime.parse(endTimeController.text);
    int duration=int.parse(durationController.text);
    Categ type=typeController.text

    Productivity newTask=Productivity(
      taskName: taskName, 
      startTime: startTime, endTime: endTime, duration: duration, type: type)
  }

  addNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Add new task"),
              content: Form(
                  child: Column(
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
                    onTap: ()async{
                     DateTime? pickedDate=await showDatePicker(
                      context: context, 
                      initialDate:DateTime.now(), 
                      firstDate: DateTime(2000), 
                      lastDate: DateTime.now());
                      if(pickedDate!=null){
                        String formattedDate=DateFormat('d/M/y HH:mm').format(pickedDate);
                        setState(() {
                          startTimeController.text=formattedDate;
                        });
                      }
                    },

                  ),
                  TextField(
                    controller: endTimeController,
                    decoration: InputDecoration(
                      label: Text('End Time'),
                    ),
                    onTap: () async{
                     DateTime? pickedDate=await showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2000), 
                      lastDate: DateTime.now()) ;
                    
                    if(pickedDate!=null){
                      String formattedDate=DateFormat('d/M/y HH:mm').format(pickedDate);
                      setState(() {
                        endTimeController.text=formattedDate;
                      });
                    }
                    }
                  ),
                  TextField(
                    controller: durationController,
                    decoration: InputDecoration(
                      label: Text('Duration'),
                    ),
                  ),
                  DropdownButton(
                    value: selectedType,
                    items: typeList
                        .map((value) => DropdownMenuItem(
                            value: value, child: Text(value.toString())))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                  ),
                ],
              )),
              actions: 
              [
                MaterialButton(
                  child:Text('Save')
                  onPressed: submitForm)
              ],);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productivityProv = ref.watch(productivityProvider);
        productivityProv.addToProductivityList();
        return Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: addNewTask),
            body: ListView.builder(
              itemCount: productivityProv.getProductivityList().length,
              itemBuilder: (context, index) {
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
            ));
      },
    );
  }
}
