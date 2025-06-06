# DateFeedBack タスク一覧

## 📋 概要

マッチングアプリ等で出会った異性とのデート会話を録音・分析し、フィードバックを提供する Flutter Web アプリケーションの実装タスクを整理します。MVC パターンと HooksRiverpod を採用し、段階的に機能を実装していきます。

## ✅ タスクリスト

### フェーズ 1: プロジェクトセットアップ

1. **プロジェクト初期化**

   - 概要: Flutter Web プロジェクトの作成と基本設定
   - 完了条件:
     - [x] `flutter create`でプロジェクト作成
     - [x] `pubspec.yaml`に必要なパッケージを追加
       - hooks_riverpod
       - firebase_core
       - firebase_auth
       - cloud_firestore
       - google_cloud_storage
     - [x] Firebase/GCP プロジェクトの設定
     - [x] GitHub リポジトリの設定
   - 動作確認:
     - [x] `flutter pub get`が正常に完了
     - [x] `flutter run -d chrome`でビルドが通ること
     - [ ] Firebase 接続確認
   - メモ: バージョン指定は`pubspec.yaml`で明示的に行う

2. **ディレクトリ構造の整備**
   - 概要: MVC パターンに基づくディレクトリ構造の作成
   - 完了条件:
     - [ ] 以下のディレクトリ構造を作成:
       ```
       lib/
       ├── auth/
       │   ├── models/
       │   ├── views/
       │   ├── controllers/
       │   └── providers/
       ├── upload/
       │   ├── models/
       │   ├── views/
       │   ├── controllers/
       │   └── providers/
       ├── analysis/
       │   ├── models/
       │   ├── views/
       │   ├── controllers/
       │   └── providers/
       └── core/
           ├── constants/
           ├── utils/
           └── widgets/
       ```
   - 動作確認:
     - [ ] ディレクトリ構造が正しく作成されていること

3. **画面遷移の導入**
   - 完了条件:
     - [ ] 画面遷移方法として go_router パッケージを導入
     - [ ] 画面遷移先としてアップロード画面と詳細画面を定義
     - [ ] アップロード画面から詳細画面（中身の実装は不要）への遷移を追加

### フェーズ 2: 音声アップロード機能実装

1. **アップロード UI の実装**

   - 概要: 音声ファイルアップロード画面の実装
   - 完了条件:
     - [x] `UploadPage` (HookConsumerWidget)の実装
     - [x] ファイル選択ダイアログ対応
     - [x] アップロード進捗のローディング表示（冒頭15分ファイルの進捗を表示）
     - [ ] アップロード済みファイル一覧の表示
   - 動作確認:
     - [x] ファイル選択の動作確認
     - [x] アップロード時の動作確認（音声ファイルをアップロードした際に画面全体にローディングが表示される）
     - [x] ローディングの表示確認
     - [ ] エラー表示の確認

2. **アップロードモデルの実装**

   - 概要: 音声ファイルアップロードに関するモデルの実装
   - 完了条件:
     - [x] `AudioFileModel`クラスの実装
     - [x] Firebase Storage 署名付き URL 生成ロジックの実装
   - 動作確認:
     - [x] Firebase Storage へのアップロードテスト

3. **アップロード状態管理の実装**
   - 概要: アップロード状態の HooksRiverpod 実装
   - 完了条件:
     - [x] `UploadController`の実装
     - [x] `UploadNotifier`の実装
     - [ ] 冒頭15分ファイルのアップロード状態管理
   - 動作確認:
     - [x] アップロード状態の変更テスト
     - [ ] エラーハンドリングのテスト

4. **ファイル一覧取得の実装**

   - 概要: アップロード済みファイル一覧の取得
   - 完了条件:
     - [ ] Firestore 上のファイル用ドキュメントをで購読する
   - 動作確認:
     - [ ] Firestore 上のファイル用ステータスの更新状況を動的に取得出来ている
     - [ ] ステータスに応じて デザイン通りに UI 上に反映出来ている

### フェーズ 3: 分析結果表示機能実装

1. **分析モデルの実装**

   - 概要: 分析結果に関するモデルクラスの実装
   - 完了条件:
     - [ ] `TranscriptModel`の実装
     - [ ] `FeedbackModel`の実装
     - [ ] `AnalysisModel`の実装
   - 動作確認:
     - [ ] ユニットテストの作成と実行
     - [ ] JSON パース処理の確認

2. **音声プレイヤーの実装**

    - 概要: 音声再生機能の実装
    - 完了条件:
      - [ ] `AudioPlayerWidget` (HookConsumerWidget)の実装
      - [ ] 再生/一時停止/シーク機能
    - 動作確認:
      - [ ] 音声再生の動作確認
      - [ ] シーク機能の動作確認

3. **文字起こし表示の実装**

    - 概要: 文字起こし結果表示機能の実装
    - 完了条件:
      - [ ] `TranscriptWidget` (HookConsumerWidget)の実装
      - [ ] 話者別の表示スタイル
      - [ ] タイムスタンプ表示
    - 動作確認:
      - [ ] 表示レイアウトの確認
      - [ ] スクロール動作の確認

4. **グラフ表示の実装**

    - 概要: 非言語情報のグラフ表示機能の実装
    - 完了条件:
      - [ ] `GraphWidget` (HookConsumerWidget)の実装
      - [ ] 時系列データの描画
    - 動作確認:
      - [ ] グラフ描画の確認
      - [ ] インタラクションの確認

5. **フィードバック表示の実装**

    - 概要: AI フィードバック表示機能の実装
    - 完了条件:
      - [ ] `FeedbackWidget` (HookConsumerWidget)の実装
      - [ ] Markdown パース処理
    - 動作確認:
      - [ ] カード表示の確認
      - [ ] Markdown 描画の確認

6. **分析結果状態管理の実装**
    - 概要: 分析結果の状態管理実装
    - 完了条件:
      - [ ] `AnalysisController`の実装
      - [ ] 各種 Notifier の実装
    - 動作確認:
      - [ ] 状態更新の伝播確認
      - [ ] エラーハンドリングの確認

### フェーズ 4: 認証機能実装

1. **認証モデルの実装**

   - 概要: ユーザー認証に関するモデルクラスの実装
   - 完了条件:
     - [ ] `UserModel`クラスの実装
     - [ ] Firebase Authentication との連携
   - 動作確認:
     - [ ] ユニットテストの作成と実行
     - [ ] `

## 優先度：MEDIUM（基本機能後に着手）

### エラーハンドリング

- [ ] エラーメッセージの日本語化
- [ ] エラー表示コンポーネント（エラーダイアログ）実装
- [ ] 各種エラー（アップロード失敗、音声処理エラー、Gemini API エラー）発生時にエラーダイアログを表示し、ユーザーに分かりやすく通知する
- [ ] リトライ処理実装（必要に応じて再アップロードや再分析の案内を行う）
