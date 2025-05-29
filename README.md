# DateFeedBack

## 📋 プロジェクト概要

DateFeedBackは、マッチングアプリ等で出会った異性との**実際のデートの会話を録音**し、分析結果を通じてユーザーにフィードバックを提供することで、**恋愛スキル向上を支援する Flutter Web アプリケーション**です。

音声ファイルをアップロードすると、AI（Gemini 2.5 Pro）が会話を分析し、文字起こし、非言語情報（声のテンション、間の取り方など）の分析、コミュニケーションに関するフィードバックを提供します。

## 🎯 主な機能

- **音声アップロード機能**
  - スマートフォンで録音した音声ファイル（最大15分）をアップロード
  - 対応形式：MP3 / WAV（16kHz mono 推奨）

- **文字起こし（Speech-to-Text）**
  - Gemini 2.5 Pro を利用した高精度な日本語文字起こし
  - 話者分離（男女2名想定）による会話形式の出力（👨 / 👩）

- **非言語情報分析**
  - 声のテンション・会話の間・被せ・沈黙などを分析
  - 会話の盛り上がり/沈静化を示す時間軸のグラフ表示

- **AIフィードバック生成**
  - 会話内容と非言語情報を基に、男性話者のコミュニケーションに関する「良かった点」と「改善提案」を生成
  - 女性話者の反応を重視した評価

- **結果表示UI**
  - 単一のスクロール可能なページに以下のセクションを表示：
    - 音声プレイヤー
    - 文字起こし表示（会話ログ）
    - 非言語情報（グラフ・説明）
    - フィードバックカード（最大5個）

## 🛠️ 技術スタック

- **フロントエンド**: Flutter Web
- **バックエンド**: Firebase / Google Cloud Platform
- **AI処理**: Gemini 2.5 Pro
- **状態管理**: HooksRiverpod
- **ストレージ**: Firebase Storage / Vertex AI Files API
- **データベース**: Firestore

## 📂 ディレクトリ構成

本プロジェクトは「feature-first」アプローチを採用しており、機能ごとにディレクトリを分割しています。

```
lib/
├── core/                 # 共通コンポーネント
│   ├── constants.dart    # 定数定義
│   ├── themes.dart       # テーマ設定
│   └── widgets/          # 共通ウィジェット
│       ├── loading_indicator.dart
│       └── error_dialog.dart
├── features/             # 機能別ディレクトリ
│   ├── auth/             # 認証機能
│   │   ├── models/       # データモデル
│   │   ├── views/        # UI表示
│   │   │   └── login_page.dart
│   │   ├── controllers/  # 状態管理
│   │   │   └── auth_controller.dart
│   │   └── repositories/ # データソース接続
│   │       └── auth_repository.dart
│   ├── upload/           # 音声アップロード機能
│   │   ├── models/
│   │   ├── views/
│   │   │   └── upload_page.dart
│   │   ├── controllers/
│   │   │   └── upload_controller.dart
│   │   └── repositories/
│   │       └── upload_repository.dart
│   └── analysis/         # 分析結果表示機能
│       ├── models/
│       ├── views/
│       │   └── analysis_page.dart
│       ├── controllers/
│       │   └── analysis_controller.dart
│       └── repositories/
│           └── analysis_repository.dart
└── main.dart             # アプリケーションのエントリーポイント
```

### 各ファイルの役割

#### features ディレクトリ

各機能ごとに`features`ディレクトリに格納する、`feature-first`という方式を採用しています。

- **`xxx_page.dart`**: 画面描画やlocal stateの管理を担当
  - 画面の描画を行う
  - 共通化が可能なウィジェットは自身のfeature内 or `core` ディレクトリ側でコンポーネント化
  - クラス内で完結するローカルな状態管理は`flutter_hooks`を用いて行う
    - ボタンのonPressedを丸ごとcontroller側で行うような運用にすると返って複雑な状態管理となってしまうので行わない
    - 参考: [Riverpod - Avoid using providers for ephemeral state](https://riverpod.dev/docs/essentials/do_dont#avoid-using-providers-for-ephemeral-state)
  - スナックバー表示などのエラーハンドリングもここで行う

- **`xxx_controller.dart`**: 外部サービス接続の橋渡し及びグローバルな状態管理を担当
  - 外部サービスの利用時、画面側との橋渡し役としてリポジトリへ接続する
  - グローバルに扱いたい状態管理もここで行う

- **`xxx_repository.dart`**: 外部サービスへの接続を担当
  - FirestoreやStorageといったデータソースへの接続はこのレイヤーのクラスから行う
  - アプリ上で必要なモデルクラスへの関連したロジックもここに記載する

#### core ディレクトリ

- featureを横断して利用するものはこの`core`ディレクトリへ格納する
- UIコンポーネントについては、featureを超えて共通化する場合は、`core` ディレクトリ内の `widgets` ディレクトリへ格納する
- UIが存在せずに外部サービスと接続するようなファイル(例: `analytics_repository.dart`)は、`feature`ディレクトリではなく`core`ディレクトリへ入れることを検討

## 🔄 処理フロー

1. Flutter Webから音声ファイルをアップロード
2. Firebase Storage / Vertex AI Files APIに保存
3. Eventarcでトリガーされ、Cloud Runが処理を開始
4. Gemini 2.5 Proによる音声分析（文字起こし、非言語情報分析、フィードバック生成）
5. 結果をFirestoreに保存
6. Flutter Webアプリが結果を検知し、UIに表示

## 🚀 開発環境のセットアップ

### 必要な環境
- Flutter 3.19.0
- Dart 3.3.0
- Node.js 18.x以上（Firebase Tools用）

### セットアップ手順

1. リポジトリのクローン
```bash
git clone https://github.com/GrassVenture/date-feed-back.git
cd date-feed-back
```

2. 依存パッケージのインストール
```bash
cd date_feed_back
flutter pub get
```

3. 環境変数の設定
```bash
cp .env.development.example .env.development
# .env.development を編集して必要な値を設定
```

4. Firebase設定
```bash
# Firebase CLIのインストール（未インストールの場合）
npm install -g firebase-tools

# Firebaseにログイン
firebase login

# Firebaseプロジェクトの設定
firebase use --add
```

5. アプリケーションの実行
```bash
flutter run -d chrome
```

## 🔧 開発・本番環境

本プロジェクトでは、開発環境と本番環境を切り替える仕組みが実装されています。

- `main.dart` で `kReleaseMode` を使い、環境を自動で切り替え
  - 開発ビルド（`flutter run` など）→ 開発用 Firebase
  - 本番ビルド（`flutter build web` など）→ 本番用 Firebase

## 🔄 開発フロー

1. `develop`ブランチから機能ブランチを作成
2. 実装完了後、PRを作成
3. レビュー＆CIチェック
4. `develop`ブランチにマージ
5. `main`ブランチへのマージで本番環境にデプロイ

## 🧪 テスト

```bash
# テストの実行
flutter test

# カバレッジレポートの生成
flutter test --coverage
```

## 📝 コーディング規約

### ドキュメンテーションコメントの記載ルール

- 日本語でコメントやドキュメントを書く場合、アルファベットと日本語の間にスペースを入れ、文末は `。` で終える（例: `PDF ファイルを保存する。`）
- すべてのパブリックなクラス、関数、メソッド、プロパティに `///` 形式のドキュメンテーションコメントを記載する
- コメントは必ず一文の要約から始める
  - 最初の文で、その要素の主な目的や役割を簡潔に説明する
  - 一文要約の後は空行で区切り、詳細説明や補足情報を続けて記載する

### Provider の定義場所
- `Provider` は、関連する `Repository` や `Service` の実装が存在するファイル内に定義する

```dart
// auth_repository.dart
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository {
  // 実装
}
```
