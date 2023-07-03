import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivityapp/components/productivity_tile.dart';
import 'package:productivityapp/main.dart';
import 'package:productivityapp/productivity_tools.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productivityProv = ref.watch(productivityProvider);
        productivityProv.addToProductivityList();
        return Scaffold(
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
                endTime: productivityProv.getProductivityList()[index].endTime,
                type: productivityProv.getProductivityList()[index].type);
          },
        ));
      },
    );
  }
}
