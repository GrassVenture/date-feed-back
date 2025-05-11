# DateFeedBack 設計方針書

## 📋 概要

マッチングアプリ等で出会った異性とのデート会話を録音・分析し、フィードバックを提供する Flutter Web アプリケーションの実装方針を定義します。

## 🔍 要件の分析

主要な実装ポイントは以下の通りです：

1. **音声アップロード**

   - 最大 15 分の音声ファイル（MP3/WAV）
   - 16kHz mono を推奨
   - アップロード進捗の表示
   - 15 分を超える音声ファイルはクライアント側で冒頭の 15 分のみを抽出し、その部分だけをアップロードする

2. **音声分析パイプライン**

   - 文字起こし（話者分離含む）
   - 非言語情報の抽出
   - AI フィードバック生成

3. **UI 表示**

   - 音声プレイヤー
   - 文字起こし表示
   - 非言語情報グラフ
   - フィードバックカード

4. **認証機能**
   - メールアドレス/パスワードによるログイン

## 🛠 実装方針

### 開発環境設定

**Flutter Version Management (FVM)**

- プロジェクトの Flutter バージョンを固定（stable）
- チーム間での開発環境の統一
- CI での再現性の確保

**セットアップ手順**

1. fvm のインストール

   ```bash
   brew tap leoafarias/fvm
   brew install fvm
   ```

2. プロジェクトの Flutter バージョン設定

   ```bash
   fvm install stable
   fvm use stable
   ```

3. VSCode 設定（.vscode/settings.json）

   ```json
   {
     "dart.flutterSdkPath": ".fvm/flutter_sdk"
   }
   ```

4. GitIgnore 設定
   ```
   .fvm/flutter_sdk
   ```

### アーキテクチャ選択

**クライアントサイド（Flutter Web）**

- MVC パターンを採用
  - Model: ビジネスロジックとデータ構造
  - View: UI コンポーネント（HookConsumerWidget）
  - Controller: Model と View の橋渡し
- HooksRiverpod による状態管理
  - Provider Pattern
  - Flutter Hooks（useState, useEffect 等）
  - 依存性注入
  - 自動的なメモ化
  - ステート管理の簡素化

**サーバーサイド（Firebase/GCP）**

- サーバーレスアーキテクチャを採用
- イベント駆動型の処理フロー
- マイクロサービス的な Cloud Run 実装

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
       H->>C: ファイル長チェック・冒頭 15 分抽出
       C->>P: 抽出した 15 分ファイルを uploadAudio()
       P->>GCS: 署名付きURLでアップロード
       P->>CR: 分析リクエスト
       CR->>FS: 文字起こしデータ保存
       CR->>FS: ステータス更新
       CR->>FS: 非言語分析データ保存
       CR->>FS: ステータス更新
       CR->>FS: フィードバックデータ保存
       CR->>FS: ステータス更新
       P->>M: モデル更新
       M-->>V: UI更新（HooksRiverpod経由）
       Note over V: アップロード失敗・音声処理エラー・Gemini API エラー時はエラーダイアログを表示
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

- クライアントで 15 分を超える音声ファイルが選択された場合、冒頭 15 分のみを抽出してアップロードする
- 15 分以内のファイルはそのままアップロードする

#### 選択肢1: サーバー側で切り捨て

- クライアントはそのままファイルをアップロードし、サーバー側で 15 分以降を切り捨てる
- メリット: クライアント実装がシンプル
- デメリット: 大容量ファイルのアップロード失敗リスク、無駄な通信量

#### 選択肢2: クライアント側で抽出（採用）

- クライアントで冒頭 15 分のみを抽出し、その部分だけをアップロード
- メリット: 通信量・アップロード時間の最適化、失敗リスク低減
- デメリット: クライアント実装がやや複雑

#### 決定: クライアント側で抽出

- モバイル/ブラウザの安定性・ユーザー体験を重視し、クライアント側で冒頭 15 分のみアップロードを採用

### 状態管理

#### 採用技術: HooksRiverpod

HooksRiverpod を採用することで、以下の利点を活かした実装を行います：

- **関数型プログラミングの恩恵**

  - useState や useEffect による直感的なステート管理
  - カスタムフックによるロジックの再利用
  - 副作用の制御が容易

- **型安全性**

  - コンパイル時の型チェック
  - IDE のサポートが充実
  - リファクタリングが容易

- **テスタビリティ**

  - Provider の依存関係が明確
  - モック作成が容易
  - ユニットテストが書きやすい

- **開発効率**
  - ボイラープレートコードの削減
  - コード量の削減
  - メンテナンス性の向上

#### 実装方針

1. **StateNotifierProvider の活用**

   ```dart
   // 状態の定義
   class AnalysisState {
     final bool isProcessing;
     final TranscriptModel? transcript;
     final NonVerbalAnalysisModel? nonVerbalAnalysis;
     final FeedbackModel? feedback;
     final String? error;
     // ...
   }

   // StateNotifierの実装
   class AnalysisNotifier extends StateNotifier<AnalysisState> {
     AnalysisNotifier() : super(AnalysisState());

     Future<void> fetchAnalysis(String sessionId) async {
       // Firestoreから直接データを取得
       final doc = await _firestore.collection('sessions').doc(sessionId).get();
       final data = doc.data();

       if (data != null) {
         state = state.copyWith(
           transcript: TranscriptModel.fromJson(data['transcript']),
           nonVerbalAnalysis: NonVerbalAnalysisModel.fromJson(data['nonVerbalAnalysis']),
           feedback: FeedbackModel.fromJson(data['feedback']),
         );
       }
     }
   }

   // Providerの定義
   final analysisProvider = StateNotifierProvider<AnalysisNotifier, AnalysisState>((ref) {
     return AnalysisNotifier();
   });
   ```

2. **Hooks の活用**

   ```dart
   class AnalysisPage extends HookConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       // ローカルステート
       final sessionId = useState<String?>(null);

       // 副作用の制御
       useEffect(() {
         if (sessionId.value != null) {
           ref.read(analysisProvider.notifier).fetchAnalysis(sessionId.value!);
         }
         return () => cleanup();
       }, [sessionId.value]);

       // Providerの監視
       final analysisState = ref.watch(analysisProvider);

       // ...
     }
   }
   ```

3. **カスタム Hooks の作成**

   ```dart
   // 再利用可能なロジックをカスタムHookとして実装
   Stream<DocumentSnapshot> useSessionStream(String sessionId) {
     final stream = useState<Stream<DocumentSnapshot>?>(null);

     useEffect(() {
       stream.value = _firestore
           .collection('sessions')
           .doc(sessionId)
           .snapshots();
       return null;
     }, [sessionId]);

     return stream.value!;
   }
   ```

### UI 実装

#### 選択肢 1: Material Design

- Flutter の標準デザイン
- 実装が容易

#### 選択肢 2: カスタムデザイン

- ユニークな UI/UX
- 実装コストが高い

#### 決定: Material Design + カスタムウィジェット

- 基本は Material Design を踏襲
- フィードバックカードなど特徴的な部分のみカスタム実装

## 📊 技術的制約と考慮事項

1. **音声ファイル制約**

   - サイズ: 最大 15 分（約 28MB@16kHz mono）
   - 形式: MP3/WAV
   - 保存先: Google Cloud Storage
   - 15 分を超える音声ファイルはクライアント側で冒頭 15 分のみを抽出し、その部分だけをアップロードする必要がある

2. **API エンドポイント**

   - Cloud Run API: `/analyzeAudio`
     - Method: POST
     - Parameters: file_uri, user_id
     - Response: { session_id: string }

3. **Firestore 制約**
   - ドキュメントサイズ: 最大 1MB
   - 文字起こし、非言語分析、フィードバックデータは 3 つのドキュメントに保存
   - リアルタイム更新のための`onSnapshot`リスナーを使用

- エラーハンドリング: アップロード失敗、音声処理エラー、Gemini API エラー発生時はユーザーにエラーダイアログを表示し、エラー内容を明示する。必要に応じてリトライや再アップロードの案内も行う。

## ❓ 解決すべき技術的課題

2. **パフォーマンス**

   - 大きな音声ファイルのアップロード時の挙動（Flutter Web での冒頭 15 分抽出実装、Blob.slice などの利用）
   - 抽出した 15 分ファイルのアップロード進捗管理とリトライ処理

3. **エラーハンドリング**
   - 各処理ステップでのエラー検出と通知
   - リカバリー方法の確立
   - Firestore のクォータ制限への対応

- エラーハンドリングの実装: 各種エラー発生時にエラーダイアログを表示し、ユーザーに分かりやすく通知する方法の設計。
