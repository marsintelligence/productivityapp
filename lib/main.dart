import 'package:productivityapp/productivity_tools.dart';
import 'package:flutter/material.dart';
import 'package:productivityapp/homePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productivityProvider = Provider<ProductivityTools>((ref) {
  return ProductivityTools();
});

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // A widget which will be started on application startup
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
