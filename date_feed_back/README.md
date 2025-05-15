# date_feed_back

---

## Firebase 本番・開発環境の自動切り替えについて

このプロジェクトでは、**ビルドモード（開発/本番）によって自動的に Firebase の設定が切り替わります**。

- 開発用: `lib/firebase_options_dev.dart`
- 本番用: `lib/firebase_options.dart`

### 仕組み

- `main.dart` で `kReleaseMode` を使い、
  - 開発ビルド（`flutter run` など）→ 開発用 Firebase
  - 本番ビルド（`flutter build web` など）→ 本番用 Firebase
    を自動で切り替えています。

### コマンド例

- **開発環境で起動**

  ```bash
  fvm flutter run -d chrome
  ```

  → 開発用 Firebase（datefeedbackdev）に接続されます

- **本番ビルド**
  ```bash
  fvm flutter build web
  ```
  → 本番用 Firebase（datefeedback）に接続されます

> 以前のような `--dart-define=FLAVOR=dev` などのコマンドは不要です。

---
