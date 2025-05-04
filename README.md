# DateFeedBack

マッチングアプリ等で出会った異性とのデート会話を録音・分析し、フィードバックを提供するFlutter Webアプリケーション。

## 開発環境のセットアップ

### 必要な環境
- Flutter 3.19.0
- Dart 3.3.0
- Node.js 18.x以上（Firebase Tools用）

### セットアップ手順

1. リポジトリのクローン
```bash
git clone https://github.com/yourusername/date-feed-back.git
cd date-feed-back
```

2. 依存パッケージのインストール
```bash
flutter pub get
```

3. 環境変数の設定
```bash
cp .env.development.example .env.development
# .env.development を編集して必要な値を設定
```

4. アプリケーションの実行
```bash
flutter run -d chrome
```

## アーキテクチャ

- MVCパターン
- HooksRiverpodによる状態管理
- Firebase/GCPによるバックエンド

## 開発フロー

1. `develop`ブランチから機能ブランチを作成
2. 実装完了後、PRを作成
3. レビュー＆CIチェック
4. `develop`ブランチにマージ
5. `main`ブランチへのマージで本番環境にデプロイ

## テスト

```bash
# テストの実行
flutter test

# カバレッジレポートの生成
flutter test --coverage
```