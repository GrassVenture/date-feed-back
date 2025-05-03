# DateFeedBackの仕様書

Owner: Kim Sokuhon
Created time: May 1, 2025 10:25 PM

[仕様書](https://www.notion.so/1e8a4128da0f80c5a2c3f90c2dd599c9?pvs=21)

こちらが「デートの録音分析アプリ」の**仕様書**として `Cursor` に読み込ませるのに適した構成で

す。読みやすさ・構造の明確さを意識し、Markdown形式で記述しています。

---

### 📄 デート録音分析アプリ 仕様書（MVP版）

---

### ✅ アプリ概要

このアプリは、マッチングアプリ等で出会った異性との**実際のデートの会話を録音**し、以下の機能を用いてユーザーに**フィードバックを提供**する**恋愛スキル向上支援ツール**です。

---

### 🧩 コア機能（MVP）

1. **音声アップロード機能**
    - ユーザーがスマホで録音した音声（最大15分）をアップロード可能
    - 対応形式：MP3 / WAV（16kHz mono 推奨）
2. **文字起こし（Speech-to-Text）**
    - Gemini 2.5 Pro を利用
    - 出力は会話形式（話者分離あり）で整形（例：👨 / 👩）
    - 話者数は基本2名（男女想定）
3. **非言語情報抽出**
    - 声のテンション・間の取り方・被せ・沈黙などを分析
    - 将来的には音声特徴量（ピッチ・スピード・音量）も活用予定
4. **AIフィードバック生成**
    - 会話内容をLLMに送信し、以下の観点でフィードバックを出力：
        - 話題の深掘り度
        - 相手の価値観への共感や質問の自然さ
        - 会話テンポ・聞き方・空気の読み方 など
5. **UI構成（スクロールビュー）**
    - 上から順に次の4セクションが表示される：
        - 音声プレイヤー
        - 文字起こし表示（会話ログ）
        - 非言語情報（棒グラフ・簡易説明）
        - フィードバックカード（最大5個）

---

### 🔐 認証・ユーザー管理（後回し）

- MVPではログイン機能のみは、今日は一旦後回し
- サインアップ機能は不要

---

### 環境

本番環境と開発環境を用意する。

---

### 📱 対応プラットフォーム

- WEB
- Flutter WEB にて開発予定

---

### 📦 使用技術（想定）

| 機能 | 使用技術・サービス |
| --- | --- |
| 音声アップロード | Firebase Storage / Cloud Functions |
| 音声変換（STT） | gemini 2.5 pro |
| 話者分離 | gemini 2.5 pro |
| LLM分析 | gemini 2.5 pro |
| フロント | Flutter web |
| サーバー | Cloud Functions or Firebase Hosting |

---

### 🧪 テスト対象例（仕様テスト）

- 10分間のデート音声（男女会話）で正常に話者分離・文字起こしされるか
- 発話ごとのテンポや間が非言語評価に反映されるか
- 文字起こしのログからLLMがフィードバックを返すか

---

### 🚧 今後の拡張候補（参考）

- 2人以上の話者検出
- モノローグでの自己トレーニングモード
- 過去のログの保存・比較・グラフ表示
- 音声録音機能そのものの内蔵

---

処理の流れ

1. flutter webから音声ファイルをアップロード
2. GCSにアップロードされて処理からevent arcなどでgeminiを起動
3. fire storeにアウトプットをインサートする
4. flutter webで検知する。

必要であれば `.md` ファイルとしてエクスポートも可能です。Cursorに渡す形に変換して出力しますか？

---

### 🔧 詳細ステップ

| # | 処理 | 主要サービス | 備考 |
| --- | --- | --- | --- |
| 1 | Flutter Web で録音完了 → **署名付き URL** 経由で **Files API** に直 PUT | Vertex AI Files API | response で `file_id` をフロントに返す |
| 2 | Files API の `upload.complete` → **Eventarc** で **Cloud Run** Trigger | Eventarc | payload に `file_id`, metadata（userId 等） |
| 3 | Cloud Run① Files API から GCS に一時 DL② `ffmpeg` で 15 分チャンク分割 | Cloud Run (Python) | `ffmpeg -t 900` |
| 4 | Cloud Run → Gemini 2.5 Pro (`generateContent`) `audio_file=Part.from_file_id(first_chunk_id)` | Vertex AI | `response_mime_type=application/json` で transcript+speaker JSON |
| 5 | Cloud Run：・`transcript.json` → GCS・Fire‑store `sessions/{docId}` に status=done, transcriptUri | Firestore / GCS | 軽量メタのみ Firestore |
| 6 | Flutter Web は Firestore `onSnapshot` で検知し UI 更新 | Flutter Web | 音声プレーヤー＋文字起こし＋フィードバック表示 |

---

### 🔄 シーケンス図（Mermaid）

```mermaid
mermaid
コピーする編集する
sequenceDiagram
    autonumber
    participant U as User (Browser)
    participant FW as Flutter Web
    participant FAPI as Vertex AI Files API
    participant EA as Eventarc
    participant CR as Cloud Run (Splitter+Gemini)
    participant GEM as Gemini 2.5 Pro
    participant GCS as Cloud Storage
    participant FS as Firestore

    U->>FW: レコーディング完了
    FW->>FAPI: PUT /upload (署名付きURL)  ※file
    FAPI-->>FW: file_id

    FAPI-->>EA: upload.complete event (file_id, metadata)
    EA->>CR: HTTP POST

    CR->>FAPI: GET file (stream)
    CR->>GCS: temp.wav 保存
    alt length > 15min
        CR->>CR: ffmpeg 分割(0‑15min, 15‑30…)
    end
    CR->>GEM: generateContent(audio_part=first_chunk_id)
    GEM-->>CR: JSON result (transcript+speaker)

    CR->>GCS: transcript.json
    CR->>FS: sessions/{docId} {status:"done", transcriptUri}

    FS-->>FW: onSnapshot update
    FW->>U: UI に文字起こし&フィードバック表示

```

---

## 3. 構成上のポイント

1. **ファイル分割ロジック**
    - Gemini 2.5 Pro Preview では ~50 MB/リクエストが安全圏。
    - 15 分以内 (16 kHz mono ≒ 28 MB) なら単一呼び出し可。
2. **Files API vs GCS**
    - Files API は Vertex AI 側ストレージ → 権限まわりが楽。
    - 既存 GCS ワークフローを優先したい場合は**署名付き URL→GCS**→Cloud Run で OK。
3. **JSON 出力強制**
    - `system_instruction` で `response_mime_type="application/json"`
    - フロントは JSON をそのままレンダリングしやすい。
4. **料金試算**
    - Gemini 2.5 Pro Preview : 現行の公開レート未定（1 M token 入力上限）。
    - 音声 15 分 = ~80 k tokens 入力 + ~5 k 出力 → 数十円〜（推定）。
    - Speech‑to‑Text経由よりは高いが分割回数を抑えれば MVP では許容範囲。