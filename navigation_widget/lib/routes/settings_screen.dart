import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic>? data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the Settings Screen'),
            Text('Received ID : ${data?["id"]}', style: TextStyle(fontSize: 20)),
            Text('Received Name : ${data?["name"]}', style: TextStyle(fontSize: 20)),
            Text('Received Content : ${data?["content"]}', style: TextStyle(fontSize: 20)),
          ],
        )
      ),
    );
  }
}