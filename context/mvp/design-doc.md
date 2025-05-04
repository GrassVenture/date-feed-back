# DateFeedBack 設計方針書

## 📋 概要

マッチングアプリ等で出会った異性とのデート会話を録音・分析し、フィードバックを提供する Flutter Web アプリケーションの実装方針を定義します。

## 🔍 要件の分析

主要な実装ポイントは以下の通りです：

1. **音声アップロード**
   - 最大15分の音声ファイル（MP3/WAV）
   - 16kHz monoを推奨
   - アップロード進捗の表示

2. **音声分析パイプライン**
   - 文字起こし（話者分離含む）
   - 非言語情報の抽出
   - AIフィードバック生成

3. **UI表示**
   - 音声プレイヤー
   - 文字起こし表示
   - 非言語情報グラフ
   - フィードバックカード

4. **認証機能**
   - メールアドレス/パスワードによるログイン

## 🛠 実装方針

### アーキテクチャ選択

**クライアントサイド（Flutter Web）**
- MVCパターンを採用
  - Model: ビジネスロジックとデータ構造
  - View: UIコンポーネント（HookConsumerWidget）
  - Controller: ModelとViewの橋渡し
- HooksRiverpodによる状態管理
  - Provider Pattern
  - Flutter Hooks（useState, useEffect等）
  - 依存性注入
  - 自動的なメモ化
  - ステート管理の簡素化

**サーバーサイド（Firebase/GCP）**
- サーバーレスアーキテクチャを採用
- イベント駆動型の処理フロー
- マイクロサービス的なCloud Run実装

### コンポーネント設計

1. **認証モジュール**
   ```
   auth/
   ├── models/
   │   └── user_model.dart
   ├── views/
   │   └── login_page.dart  // HookConsumerWidget
   ├── controllers/
   │   └── auth_controller.dart
   └── providers/
       └── auth_provider.dart  // StateNotifierProvider
   ```

2. **音声アップロードモジュール**
   ```
   upload/
   ├── models/
   │   └── audio_file_model.dart
   ├── views/
   │   └── upload_page.dart  // HookConsumerWidget
   ├── controllers/
   │   └── upload_controller.dart
   └── providers/
       ├── upload_state.dart
       └── upload_provider.dart  // StateNotifierProvider
   ```

3. **分析結果表示モジュール**
   ```
   analysis/
   ├── models/
   │   ├── transcript_model.dart
   │   ├── feedback_model.dart
   │   └── analysis_model.dart
   ├── views/
   │   ├── analysis_page.dart  // HookConsumerWidget
   │   ├── audio_player_widget.dart  // HookConsumerWidget
   │   ├── transcript_widget.dart  // HookConsumerWidget
   │   ├── graph_widget.dart  // HookConsumerWidget
   │   └── feedback_widget.dart  // HookConsumerWidget
   ├── controllers/
   │   └── analysis_controller.dart
   └── providers/
       ├── transcript_provider.dart  // StateNotifierProvider
       ├── feedback_provider.dart  // StateNotifierProvider
       └── analysis_provider.dart  // StateNotifierProvider
   ```

### データフロー

1. **音声アップロードと分析フロー**
   ```mermaid
   sequenceDiagram
       participant U as User (Browser)
       participant V as View (HookConsumerWidget)
       participant H as Hooks (useState/useEffect)
       participant C as Controller
       participant P as Provider (StateNotifier)
       participant M as Model
       participant GCS as Google Cloud Storage
       participant CR as Cloud Run
       participant FS as Firestore

       U->>V: 音声ファイル選択
       V->>H: useState/useEffect
       H->>C: uploadAudio()
       C->>P: uploadProvider.upload()
       P->>GCS: 署名付きURLでアップロード
       P->>CR: 分析リクエスト
       CR-->>FS: 結果保存
       P->>M: モデル更新
       M-->>V: UI更新（HooksRiverpod経由）
   ```

2. **状態管理フロー（HooksRiverpod）**
   ```mermaid
   graph LR
   A[User Action] --> B[Hooks]
   B --> C[Controller]
   C --> D[StateNotifierProvider]
   D --> E[Model]
   E --> F[HookConsumerWidget]
   ```

## 🔄 実装方法の選択肢と決定

### 音声アップロード

#### 選択肢1: Cloud Storage Direct Upload + Cloud Run API
- 署名付きURLを使用して直接GCSにアップロード
- Cloud Runで分析APIを提供
- シンプルで理解しやすい構成

#### 選択肢2: Vertex AI Files API + Eventarc
- Files APIに直接アップロード
- Eventarcでトリガー
- より密なGemini連携

#### 決定: Cloud Storage Direct Upload + Cloud Run API
- MVPではシンプルな構成を優先
- 既存のGCSインフラを活用
- Cloud Run APIによる柔軟な処理制御

### 状態管理

#### 採用技術: HooksRiverpod
HooksRiverpodを採用することで、以下の利点を活かした実装を行います：

- **関数型プログラミングの恩恵**
  - useStateやuseEffectによる直感的なステート管理
  - カスタムフックによるロジックの再利用
  - 副作用の制御が容易

- **型安全性**
  - コンパイル時の型チェック
  - IDEのサポートが充実
  - リファクタリングが容易

- **テスタビリティ**
  - Providerの依存関係が明確
  - モック作成が容易
  - ユニットテストが書きやすい

- **開発効率**
  - ボイラープレートコードの削減
  - コード量の削減
  - メンテナンス性の向上

#### 実装方針

1. **StateNotifierProviderの活用**
   ```dart
   // 状態の定義
   class UploadState {
     final bool isUploading;
     final double progress;
     final String? error;
     // ...
   }

   // StateNotifierの実装
   class UploadNotifier extends StateNotifier<UploadState> {
     UploadNotifier() : super(UploadState());
     
     Future<void> upload(File file) async {
       // 状態更新とロジック実装
     }
   }

   // Providerの定義
   final uploadProvider = StateNotifierProvider<UploadNotifier, UploadState>((ref) {
     return UploadNotifier();
   });
   ```

2. **Hooksの活用**
   ```dart
   class UploadPage extends HookConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       // ローカルステート
       final file = useState<File?>(null);
       
       // 副作用の制御
       useEffect(() {
         // マウント/アンマウント時の処理
         return () => cleanup();
       }, []);
       
       // Providerの監視
       final uploadState = ref.watch(uploadProvider);
       
       // ...
     }
   }
   ```

3. **カスタムHooksの作成**
   ```dart
   // 再利用可能なロジックをカスタムHookとして実装
   File? useFileUpload({
     required void Function(File) onSelect,
     List<String> allowedExtensions = const ['mp3', 'wav'],
   }) {
     final file = useState<File?>(null);
     final isHovering = useState(false);
     
     // ドラッグ&ドロップとファイル選択のロジック
     // ...
     
     return file.value;
   }
   ```

### UI実装

#### 選択肢1: Material Design
- Flutterの標準デザイン
- 実装が容易

#### 選択肢2: カスタムデザイン
- ユニークなUI/UX
- 実装コストが高い

#### 決定: Material Design + カスタムウィジェット
- 基本はMaterial Designを踏襲
- フィードバックカードなど特徴的な部分のみカスタム実装

## 📊 技術的制約と考慮事項

1. **音声ファイル制約**
   - サイズ: 最大15分（約28MB@16kHz mono）
   - 形式: MP3/WAV
   - 保存先: Google Cloud Storage

2. **APIエンドポイント**
   - Cloud Run API: `/analyzeAudio`
     - Method: POST
     - Parameters: file_uri, user_id
     - Response: { session_id: string }

3. **レスポンス制約**
   - 文字起こし: JSON形式強制
   - 非言語情報: Markdown形式
   - フィードバック: Markdown形式

## ❓ 解決すべき技術的課題

1. **音声分析精度**
   - Gemini APIの音声認識精度の検証
   - 話者分離の正確性の確認

2. **パフォーマンス**
   - 大きな音声ファイルのアップロード時の挙動
   - 分析結果表示時のレンダリング最適化

3. **エラーハンドリング**
   - 各処理ステップでのエラー検出と通知
   - リカバリー方法の確立 