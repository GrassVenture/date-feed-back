-----

# DateFeedBack

-----

## 開発環境のセットアップ

### 必要な環境

  - Flutter 3.19.0
  - Dart 3.3.0
  - Node.js 18.x以上（Firebase Tools用）

### セットアップ手順

1.  **リポジトリのクローン**

    ```bash
    git clone https://github.com/yourusername/date-feed-back.git
    cd date-feed-back
    ```

2.  **依存パッケージのインストール**

    ```bash
    flutter pub get
    ```

3.  **環境変数の設定（Envied）**
    このプロジェクトでは [`envied`](https://www.google.com/search?q=%5Bhttps://pub.dev/packages/envied%5D\(https://pub.dev/packages/envied\)) パッケージを使用して、`.env` ファイルの内容を安全に Dart コードとして使用できるようにしています。

    1.  **`.env` ファイルの準備**
        プロジェクトのルートディレクトリに `.env` ファイルを作成し、以下の内容を記述します。

        ```env
        DEV_API_URL=https://your-dev-api-url.run.app # 実際の環境変数は Kim さん (@schwarzwald0906) に確認してください！
        ```

        > **Note:** `.env` ファイルは `.gitignore` に含まれているため、Git にコミットされません。

    2.  **コード生成の実行**

        ```bash
        flutter pub run build_runner build --delete-conflicting-outputs
        ```

4.  **アプリケーションの実行**

    ```bash
    flutter run -d chrome
    ```

-----

## アーキテクチャ

  - **MVCパターン**
  - **HooksRiverpod**による状態管理
  - **Firebase/GCP**によるバックエンド

-----

## 開発フロー

1.  `develop`ブランチから機能ブランチを作成します。
2.  実装完了後、Pull Request (PR) を作成します。
3.  レビューとCI (継続的インテグレーション) チェックが行われます。
4.  `develop`ブランチにマージします。
5.  `main`ブランチへのマージにより、本番環境にデプロイされます。

-----

## テスト

```bash
# テストの実行
flutter test

# カバレッジレポートの生成
flutter test --coverage
```