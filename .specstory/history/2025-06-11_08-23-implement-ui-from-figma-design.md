<!-- Generated by SpecStory -->

# Implement UI from Figma design (2025-06-11 17:23:53)

_**User**_

@https://www.figma.com/design/XGJBa3C7VuPMR1UN2dViW1/DateFeedBack?node-id=8-181&t=AX8ZOEUDs5T4vvl5-4 

上記のFigmaデザインからUIを実装して。
実行するディレクトリは以下でお願いします。

/Users/ookuboitsuki/Flutter/date-feed-back/date_feed_back

---

_**Assistant**_

✅  User Rules  
Accuracy Estimate: 90 %  
Model: GPT-4.1  

Figma デザイン（node-id: 8-181）をもとに、指定ディレクトリ（/Users/ookuboitsuki/Flutter/date-feed-back/date_feed_back）でUIを実装します。

### 次のステップ
1. Figma の該当ノード（8-181）の構成・内容を取得し、画面設計を把握します。
2. 必要な画像アセットがあればダウンロードします。
3. Flutter でUIコードを作成します（`lib/`配下に新規ファイルを作成）。
4. 必要に応じて、`pubspec.yaml` へアセット登録や依存パッケージ追加も行います。

まずはFigmaノードの詳細情報を取得し、画面構成を確認します。

---



---



---

<details>
            <summary>Listed directory date_feed_back/lib • **9** results</summary>
        
| Name |
|-------|
| 📄 `main.dart` |
| 📁 `core` |
| 📁 `support` |
| 📁 `analysis` |
| 📁 `auth` |
| 📁 `files` |
| 📁 `upload` |
| 📄 `firebase_options.dart` |
| 📄 `firebase_options_dev.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/core • **1** results</summary>
        
| Name |
|-------|
| 📁 `routes` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/core/routes • **1** results</summary>
        
| Name |
|-------|
| 📄 `app_router.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/support • **2** results</summary>
        
| Name |
|-------|
| 📄 `mock_user.dart` |
| 📄 `mock_user.freezed.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/analysis • **1** results</summary>
        
| Name |
|-------|
| 📁 `views` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/analysis/views • **1** results</summary>
        
| Name |
|-------|
| 📄 `analysis_page.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/files • **1** results</summary>
        
| Name |
|-------|
| 📁 `views` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/files/views • **1** results</summary>
        
| Name |
|-------|
| 📄 `file_list_page.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/upload • **3** results</summary>
        
| Name |
|-------|
| 📁 `views` |
| 📁 `controllers` |
| 📁 `models` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/upload/views • **2** results</summary>
        
| Name |
|-------|
| 📄 `upload_page.dart` |
| 📄 `upload_uploading_banner.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/upload/controllers • **2** results</summary>
        
| Name |
|-------|
| 📄 `upload_controller.dart` |
| 📄 `upload_notifier.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/upload/models • **5** results</summary>
        
| Name |
|-------|
| 📄 `upload_state.freezed.dart` |
| 📄 `audio_file_model.dart` |
| 📄 `audio_file_model.freezed.dart` |
| 📄 `audio_file_model.g.dart` |
| 📄 `upload_state.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib • **9** results</summary>
        
| Name |
|-------|
| 📄 `main.dart` |
| 📁 `core` |
| 📁 `support` |
| 📁 `analysis` |
| 📁 `auth` |
| 📁 `files` |
| 📁 `upload` |
| 📄 `firebase_options.dart` |
| 📄 `firebase_options_dev.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/auth • **4** results</summary>
        
| Name |
|-------|
| 📁 `views` |
| 📁 `controllers` |
| 📁 `repositories` |
| 📁 `models` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/auth/views • **2** results</summary>
        
| Name |
|-------|
| 📄 `login_page.dart` |
| 📄 `auth_view.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib • **9** results</summary>
        
| Name |
|-------|
| 📄 `main.dart` |
| 📁 `core` |
| 📁 `support` |
| 📁 `analysis` |
| 📁 `auth` |
| 📁 `files` |
| 📁 `upload` |
| 📄 `firebase_options.dart` |
| 📄 `firebase_options_dev.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/core • **1** results</summary>
        
| Name |
|-------|
| 📁 `routes` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/lib/core/routes • **1** results</summary>
        
| Name |
|-------|
| 📄 `app_router.dart` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/assets • **1** results</summary>
        
| Name |
|-------|
| 📁 `icons` |

</details>

---

<details>
            <summary>Listed directory date_feed_back/assets/icons • **2** results</summary>
        
| Name |
|-------|
| 📄 `plus_icon.svg` |
| 📄 `close_icon_2.svg` |

</details>

---

<details>
            <summary>Grep search for "assets/icons/plus_icon.svg" • **0** files</summary>
        
No results found
</details>

---

<details>
            <summary>Grep search for "assets:" • **0** files</summary>
        
No results found
</details>

---

<details>
            <summary>Searched codebase "pubspec.yaml" • **1** results</summary>
        
| File |
|------|
| `undefined` |

</details>

---

Read file: date_feed_back/pubspec.yaml

---





---

```diff
  
  flutter:
-   uses-material-design: true 
+   uses-material-design: true
+   assets:
+     - assets/icons/plus_icon.svg 
```

---

```diff
- 
+ import 'package:flutter/material.dart';
+ import 'package:flutter_svg/flutter_svg.dart';
+ 
+ /// 新規作成ボタンウィジェット。
+ ///
+ /// Figma デザインに基づき、プラスアイコンと「新規作成」テキストを横並びで表示する。
+ class NewProjectButton extends StatelessWidget {
+   /// タップ時のコールバック。
+   final VoidCallback? onPressed;
+ 
+   /// ボタンが有効かどうか。
+   final bool enabled;
+ 
+   /// コンストラクタ。
+   const NewProjectButton({
+     super.key,
+     this.onPressed,
+     this.enabled = true,
+   });
+ 
+   @override
+   Widget build(BuildContext context) {
+     return Material(
+       color: Colors.white,
+       borderRadius: BorderRadius.circular(8),
+       elevation: 0,
+       child: InkWell(
+         borderRadius: BorderRadius.circular(8),
+         onTap: enabled ? onPressed : null,
+         child: Container(
+           padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
+           decoration: BoxDecoration(
+             color: Colors.white,
+             borderRadius: BorderRadius.circular(8),
+             boxShadow: const [
+               BoxShadow(
+                 color: Color(0xFFECECEC),
+                 offset: Offset(0, 2),
+                 blurRadius: 8,
+               ),
+             ],
+           ),
+           child: Row(
+             mainAxisSize: MainAxisSize.min,
+             crossAxisAlignment: CrossAxisAlignment.center,
+             children: [
+               Container(
+                 width: 20,
+                 height: 20,
+                 alignment: Alignment.center,
+                 child: SvgPicture.asset(
+                   'assets/icons/plus_icon.svg',
+                   width: 16,
+                   height: 16,
+                   colorFilter: const ColorFilter.mode(Color(0xFF9B6ADF), BlendMode.srcIn),
+                 ),
+               ),
+               const SizedBox(width: 8),
+               const Text(
+                 '新規作成',
+                 style: TextStyle(
+                   fontFamily: 'Noto Sans JP',
+                   fontWeight: FontWeight.w700,
+                   fontSize: 16,
+                   color: Color(0xFF9B6ADF),
+                   height: 1.2,
+                 ),
+               ),
+             ],
+           ),
+         ),
+       ),
+     );
+   }
+ } 
```

---

```diff
    roggle: ^0.4.2+1
    universal_html: ^2.2.4
+   flutter_svg: ^2.0.10
  
  dev_dependencies:
```

---

```bash
flutter pub get
```

```
flutter pub get                                                                 
date-feed-back on branch chore/figma-mcp-setupon ☁️  okuboituki19990702@gmail.com
 
❯ flutter pub get

  ╔════════════════════════════════════════════════════════════════════════════╗
  ║                 Welcome to Flutter! - https://flutter.dev                  ║
  ║                                                                            ║
  ║ The Flutter tool uses Google Analytics to anonymously report feature usage ║
  ║ statistics and basic crash reports. This data is used to help improve      ║
  ║ Flutter tools over time.                                                   ║
  ║                                                                            ║
  ║ Flutter tool analytics are not sent on the very first run. To disable      ║
  ║ reporting, type 'flutter config --no-analytics'. To display the current    ║
  ║ setting, type 'flutter config'. If you opt out of analytics, an opt-out    ║
  ║ event will be sent, and then no further information will be sent by the    ║
  ║ Flutter tool.                                                              ║
  ║                                                                            ║
  ║ By downloading the Flutter SDK, you agree to the Google Terms of Service.  ║
  ║ The Google Privacy Policy describes how data is handled in this service.   ║
  ║                                                                            ║
  ║ Moreover, Flutter includes the Dart SDK, which may send usage metrics and  ║
  ║ crash reports to Google.                                                   ║
  ║                                                                            ║
  ║ Read about data we send with crash reports:                                ║
  ║ https://flutter.dev/docs/reference/crash-reporting                         ║
  ║                                                                            ║
  ║ See Google's privacy policy:                                               ║
  ║ https://policies.google.com/privacy                                        ║
  ║                                                                            ║
  ║ To disable animations in this tool, use 'flutter config --no-animations'.  ║
  ╚════════════════════════════════════════════════════════════════════════════╝
```

---

Read file: date_feed_back/lib/main.dart

---

Read file: date_feed_back/lib/upload/views/upload_page.dart

---

```diff
  import '../controllers/upload_controller.dart';
  import 'upload_uploading_banner.dart';
+ import '../../core/new_project_button.dart';
  
  /// 音声ファイルのアップロード画面。
```

```diff
                    ),
                  ],
-               ),
+               ),
+             const SizedBox(height: 40),
+             NewProjectButton(
+               onPressed: () {
+                 // TODO: 新規作成ボタンのアクションを実装
+                 ScaffoldMessenger.of(context).showSnackBar(
+                   const SnackBar(content: Text('新規作成ボタンが押されました')),
+                 );
+               },
+             ),
            ],
          ),
```

---

✅  User Rules  
Accuracy Estimate: 98 %  
Model: GPT-4.1  

Figma デザイン（node-id: 8-181）に基づき、「新規作成」ボタンのUIをFlutterで実装し、`UploadPage` の下部に追加しました。  
また、SVGアイコン（plus_icon.svg）も assets に登録済みです。

### 実装内容
- `lib/core/new_project_button.dart` にデザイン準拠のボタンウィジェットを新規作成
- `flutter_svg` パッケージを導入し、SVGアイコンを表示
- `pubspec.yaml` で assets/icons/plus_icon.svg を assets に登録
- `UploadPage` の下部に `NewProjectButton` を追加（押下時はSnackBar表示）

### 次のステップ
- アプリを起動し、アップロード画面下部に「新規作成」ボタンが表示されることを確認してください。
- ボタンのアクション（新規作成処理）は、今はダミー（SnackBar）です。必要に応じて実装を追加してください。

他のFigma画面や追加UIも必要な場合は、node-idや画面名を指定してご依頼ください。

---

