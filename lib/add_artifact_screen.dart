import 'package:flutter/material.dart';
import 'artifact.dart'; // 引入 Artifact 类
import 'database_helper.dart'; // 引入数据库助手

class AddArtifactScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _eraController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加文物'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '品名'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: '分類'),
            ),
            TextField(
              controller: _sizeController,
              decoration: InputDecoration(labelText: '尺寸'),
            ),
            TextField(
              controller: _eraController,
              decoration: InputDecoration(labelText: '時代'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: '說明'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newArtifact = Artifact(
                  id: DateTime.now().toString(), // 使用当前时间作为 ID
                  name: _nameController.text,
                  category: _categoryController.text,
                  size: _sizeController.text,
                  era: _eraController.text,
                  description: _descriptionController.text,
                );

                final dbHelper = DatabaseHelper();
                await dbHelper.insertArtifact(newArtifact);

                // 返回到文物列表页面
                Navigator.pop(context);
              },
              child: Text('添加文物'),
            ),
          ],
        ),
      ),
    );
  }
}