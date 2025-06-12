import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// ファイル一覧画面を表示するウィジェット。
///
/// Figmaデザインに基づき、SVGアイコンや配色・レイアウトを反映する。
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
      backgroundColor: const Color(0xFFFBFAFE),
      body: Row(
        children: [
          // サイドバー
          Container(
            width: 60,
            color: Colors.transparent,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(
                  'assets/icons/home_icon2.svg',
                  width: 32,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF3C1A6C), BlendMode.srcIn),
                ),
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
                        icon: SvgPicture.asset(
                          'assets/icons/plus_icon.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF9B6ADF), BlendMode.srcIn),
                        ),
                        label: const Text(
                          '新規作成',
                          style: TextStyle(
                            color: Color(0xFF9B6ADF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Noto Sans JP',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48, vertical: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: const Color(0xFFECECEC),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/person_icon2.svg',
                                width: 14,
                                height: 14,
                                colorFilter: const ColorFilter.mode(
                                    Color(0xFF645E6D), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'UserName',
                            style: TextStyle(
                              color: Color(0xFF2F2F2F),
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'Noto Sans JP',
                            ),
                          ),
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
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32,
                        childAspectRatio: 2.2,
                      ),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFECECEC),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 4),
                                  Text(
                                    file['title']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans JP',
                                      color: Color(0xFF645E6D),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    '作成日:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF645E6D),
                                      fontFamily: 'Noto Sans JP',
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    file['date']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF645E6D),
                                      fontFamily: 'Noto Sans JP',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SvgPicture.asset(
                                    'assets/icons/play_circle_outline.svg',
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xFF645E6D), BlendMode.srcIn),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    file['time']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF645E6D),
                                      fontFamily: 'Noto Sans JP',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SvgPicture.asset(
                                    'assets/icons/person2.svg',
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xFF645E6D), BlendMode.srcIn),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    file['user']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF645E6D),
                                      fontFamily: 'Noto Sans JP',
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
