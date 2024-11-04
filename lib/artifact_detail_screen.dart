import 'package:flutter/material.dart';
import 'artifact.dart'; // 引入 Artifact 类

class ArtifactDetailScreen extends StatelessWidget {
  final Artifact artifact;

  ArtifactDetailScreen({required this.artifact}); // 接收 Artifact 对象

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artifact.name), // 顯示文物名稱
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('分類: ${artifact.category}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('尺寸: ${artifact.size}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('時代: ${artifact.era}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('說明:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(artifact.description, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}