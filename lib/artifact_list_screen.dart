import 'package:flutter/material.dart';
import 'artifact.dart';
import 'database_helper.dart';
import 'add_artifact_screen.dart'; // 引入添加文物页面
import 'artifact_detail_screen.dart'; // 引入文物详细信息页面

class ArtifactListScreen extends StatefulWidget {
  @override
  _ArtifactListScreenState createState() => _ArtifactListScreenState();
}

class _ArtifactListScreenState extends State<ArtifactListScreen> {
  List<Artifact> artifacts = [];
  List<Artifact> filteredArtifacts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadArtifacts();
  }

  Future<void> _loadArtifacts() async {
    final dbHelper = DatabaseHelper();
    final fetchedArtifacts = await dbHelper.getArtifacts();
    setState(() {
      artifacts = fetchedArtifacts;
      filteredArtifacts = fetchedArtifacts; // 初始化为完整列表
    });
  }

  void _filterArtifacts(String query) {
    setState(() {
      searchQuery = query;
      filteredArtifacts = artifacts
          .where((artifact) => artifact.name.contains(query) || artifact.category.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('文物列表')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: '搜索文物',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: _filterArtifacts, // 监听输入变化
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredArtifacts.length,
              itemBuilder: (context, index) {
                final artifact = filteredArtifacts[index];
                return ListTile(
                  title: Text(artifact.name),
                  subtitle: Text(artifact.category),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final dbHelper = DatabaseHelper();
                      await dbHelper.deleteArtifact(artifact.id);
                      _loadArtifacts(); // 重新加载数据
                    },
                  ),
                  onTap: () {
                    // 点击列表项后打开详细信息页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtifactDetailScreen(artifact: artifact),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddArtifactScreen()),
          ).then((_) {
            _loadArtifacts(); // 在返回时重新加载文物数据
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}