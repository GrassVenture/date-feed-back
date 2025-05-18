import 'package:flutter/material.dart';

class FileListPage extends StatelessWidget {
  final List<Map<String, String>> files = List.generate(
    7,
    (index) => {
      'title': 'ファイル名',
      'date': '2025/05/15',
      'time': '12:50',
      'user': '佐藤さん',
    },
  );

  FileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFF),
      body: Row(
        children: [
          // サイドバー
          Container(
            width: 60,
            color: Colors.transparent,
            child: const Column(
              children: [
                SizedBox(height: 20),
                Icon(Icons.home, color: Color(0xFFE6DFFF), size: 32),
              ],
            ),
          ),
          // メインコンテンツ
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  // ヘッダー
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Color(0xFF8B5CF6)),
                        label: const Text(
                          '新規作成',
                          style: TextStyle(color: Color(0xFF8B5CF6)),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                          const SizedBox(width: 8),
                          Text('UserName',
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // ファイルカード一覧
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                        childAspectRatio: 2.2,
                      ),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  file['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text('作成日: ${file['date']}'),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.access_time,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(file['time']!),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.person,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(file['user']!),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
