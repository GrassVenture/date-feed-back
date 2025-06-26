-----

# DateFeedBack

-----

## 開発環境のセットアップ

### 必要な環境

- **Flutter**: 3.32.4（FVM により管理）
- **Dart**: 3.8.1（Flutter SDK に同梱）
- **Node.js**: 18.x 以上（Firebase Tools 用、推奨: 最新安定版）

※ Flutter および Dart のバージョンは `.fvmrc` によりプロジェクトに固定されています。

**参考**: [FVMでFlutter SDKのバージョンをプロジェクト毎に管理する](https://zenn.dev/altiveinc/articles/flutter-version-management)


### セットアップ手順

1.  **リポジトリのクローン**

    ```bash
    git clone https://github.com/yourusername/date-feed-back.git
    cd date-feed-back
    ```

2.  **依存パッケージのインストール**

    ```bash
    fvm flutter pub get
    ```

3.  **環境変数の設定（Envied）**
    このプロジェクトでは [`envied`](https://pub.dev/packages/envied) パッケージを使用して、`.env` ファイルの内容を安全に Dart コードとして使用できるようにしています。

    1.  **`.env` ファイルの準備**
        プロジェクトのルートディレクトリに `.env` ファイルを作成し、以下の内容を記述します。

        ```env
        DEV_API_URL=https://your-dev-api-url.run.app # 実際の環境変数はこちら参照（https://www.notion.so/masakisato/env-21ea4128da0f8062b5c2dd1bca0d7bf4?source=copy_link）
        ```

        > **Note:** `.env` ファイルは `.gitignore` に含まれているため、Git にコミットされません。

    2.  **コード生成の実行**

        ```bash
        fvm flutter pub run build_runner build --delete-conflicting-outputs
        ```

4.  **アプリケーションの実行**

    ```bash
    fvm flutter run -d chrome
    ```

-----

## アーキテクチャ

  - **MVCパターン**
  - **HooksRiverpod**による状態管理
  - **Firebase/GCP**によるバックエンド

-----

## 開発フロー

1.  `main`ブランチから機能ブランチを作成します。
2.  実装完了後、Pull Request (PR) を作成します。
3.  レビューが行われます。
4.  `main`ブランチにマージします。

-----
