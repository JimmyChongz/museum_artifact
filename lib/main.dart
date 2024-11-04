import 'package:flutter/material.dart';
import 'artifact_list_screen.dart'; // 引入文物列表屏幕

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '博物館文物查詢系統',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArtifactListScreen(), // 设置首页为文物列表屏幕
    );
  }
}