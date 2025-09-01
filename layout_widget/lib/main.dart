import 'package:flutter/material.dart';
import 'package:layout_widget/models/product.dart';
import 'package:layout_widget/screens/detail_screen.dart';
import 'package:layout_widget/screens/gridview_screen.dart';
import 'package:layout_widget/screens/listview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '레이아웃 위젯',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('레이아웃 위젯'),
          centerTitle: true,
        ),
        // body: DetailScreen(product: Product(
        //   image: "image/product.jpg",
        //   title: "상품 제목 테스트1",
        //   description: "상품 설명 테스트1"
        // )),
        // body: ListviewScreen()
        body: GridviewScreen()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
