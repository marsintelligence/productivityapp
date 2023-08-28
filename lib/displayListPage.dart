import 'package:flutter/material.dart';
import 'package:productivityapp/components/showDialog.dart';
import 'package:productivityapp/productivity_tools.dart';
import 'package:provider/provider.dart';

class DisplayListPage extends StatefulWidget {
  const DisplayListPage({super.key});

  @override
  State<DisplayListPage> createState() => _DisplayListPageState();
  //List taskList = [];
}

class _DisplayListPageState extends State<DisplayListPage> {
  @override
  void initState() {
    callInitState();
    super.initState();
  }

  callInitState() async {
    final readProvider = context.read<ProductivityTools>();
    final watchProvider = context.watch<ProductivityTools>();

    await readProvider.filterProductivityListByDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final readProvider = context.read<ProductivityTools>();
    final watchProvider = context.watch<ProductivityTools>();
    addNewTask(int index) {
      return showDialog(
          context: context,
          builder: (context) {
            return ShowDialog(index: index);
          });
    }

    /*List<int> workTime = List.filled(24, 0);
    print(workTime);
    List<int> entTime = List.filled(24, 0);
    int nightWorkTime = 0;
    int nightEntTime = 0;*/
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'Total work Time:${watchProvider.workDuration.fold(0, (previousValue, element) {
                  return previousValue + element;
                })}'),
                Text(
                    'Total fun Time:${watchProvider.entDuration.fold(0, (previousValue, element) {
                  return previousValue + element;
                })}'),
                ElevatedButton(
                    onPressed: () {
                      /*
                       (int i = 0;
                          i < watchProvider.workDuration.length;
                          i++) {
                        watchProvider.workDuration[i] = 0;
                        watchProvider.entDuration[i] = 0;
                      }*/
                    },
                    child: Text('Reset'))
              ],
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: SizedBox(
                    child: const Text('0:00 - 8:00'),
                    width: 120,
                  ),
                  onPressed: () {
                    addNewTask(0);
                  },
                ),
                Container(
                  child: Text('${watchProvider.workDuration[0]}'),
                ),
                Container(
                    child: Text(
                  '${watchProvider.entDuration[0]}',
                ))
              ],
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 16,
                itemBuilder: (context, index) {
                  final adjIndex = index + 8;
                  return Column(
                    children: [
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () async {
                                return addNewTask(adjIndex);
                              },
                              child: SizedBox(
                                  width: 100,
                                  child: Text(
                                      '${adjIndex}:00 - ${adjIndex + 1}:00'))),
                          SizedBox(
                            width: 60,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color.fromARGB(255, 127, 152, 99),
                              ),
                              child: Text(
                                  '${watchProvider.workDuration[adjIndex]}'),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:
                                      const Color.fromARGB(255, 127, 152, 99),
                                ),
                                child: Text(
                                  '${watchProvider.entDuration[adjIndex]}',
                                )),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
