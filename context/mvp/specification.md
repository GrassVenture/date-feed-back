# DateFeedBack 要件定義書

## 📋 概要

マッチングアプリ等で出会った異性との実際のデートの会話を録音し、分析結果を通じてユーザーにフィードバックを提供することで、恋愛スキル向上を支援する Flutter Web アプリケーション（MVP 版）。

## 🎯 要求

- **ユーザー認証:**
  - メールアドレスとパスワードによるログイン機能を提供する。
- **音声アップロード:**
  - スマートフォンで録音した音声ファイル (最大 15 分) をアップロードできる。
  - 対応形式: MP3 / WAV (16kHz mono 推奨)。
- **音声処理と分析:**
  - アップロードされた音声を処理し、以下の情報を生成する:
    - **文字起こし:** 高精度な日本語 STT を使用し、話者分離 (男女 2 名想定) を行った会話形式のテキストを生成する。出力形式は指定された JSON 構造に従う。
    - **非言語情報:** 声のテンション、会話の間、被せ、沈黙などを分析し、指定された Markdown 形式で出力する。特に女性話者の感情やテンションの推移、会話の間の分析を含む。
    - **AI フィードバック:** 会話内容と非言語情報を基に、LLM を用いて男性話者のコミュニケーションに関する「良かった点」と「改善提案」を最大 5 つ生成する。評価は女性話者の反応を最重要視しつつ、男性話者の行動も評価する。出力は指定された Markdown 形式に従う。
- **結果表示:**
  - 分析結果を単一のスクロール可能な Web ページに表示する。
  - 表示セクションは上から順に「音声プレイヤー」「文字起こし表示」「非言語情報」「フィードバックカード」。

## 📝 機能仕様

### 画面/コンポーネント構成

- **ログイン画面:** メールアドレスとパスワード入力フィールド、ログインボタン。
- **ファイル一覧画面:**
  - 単一のスクロールビューで構成される。
  - **音声アップロードエリア:** ファイル選択ボタンでアップロード実施
  - **処理中表示:** アップロード後、分析完了までローディング表示。
- **ファイル詳細画面:**
  - **結果表示エリア (分析完了後):**
    - **音声プレイヤー:** アップロードされた音声を再生/一時停止/シーク可能。
    - **文字起こし表示:** 話者 (👨/👩) と発言内容を会話形式で表示。話題ごとに見出しと開始時間を表示。
    - **非言語情報表示:**
      - 会話の盛り上がり/沈静化を示す時間軸の**折れ線グラフ** (横軸: 時間、縦軸: 盛り上がり度など)。
      - 分析結果 (感情、間、テンション) を Markdown テキストで表示。
    - **フィードバックカード:** AI が生成した「良かった点」「改善提案」を最大 5 つ、カード形式で表示。

### 振る舞い

1.  **ログイン:** ユーザーはメールアドレスとパスワードでログインする。認証は Firebase Authentication などを使用。
2.  **音声アップロード:** ユーザーは音声ファイルを Firebase Storage へアップロードする。
3.  **ドキュメント作成:** Firebase Storage のファイルURLを Firestore のフィールドとして持たせる。
4. **APIリクエスト:**
5.  **処理開始:** ファイルアップロード完了をトリガー (Eventarc) として Cloud Run ジョブが起動。
6.  **音声分割 (必要な場合):** Cloud Run が音声ファイルをダウンロードし、15 分を超える場合は ffmpeg で最初の 15 分チャンクを抽出。
7.  **Gemini 分析:** Cloud Run が Gemini 2.5 Pro を呼び出し、指定されたプロンプトに基づき「文字起こし (JSON)」「非言語情報分析 (Markdown)」「AI フィードバック (Markdown)」を生成させる。(注: プロンプトに応じて複数回の呼び出しが必要になる可能性がある)
8.  **結果保存:** Cloud Run は生成された結果 (文字起こし JSON、非言語分析 Markdown、フィードバック Markdown) を GCS に保存し、Firestore の `sessions/{docId}` ドキュメントに処理ステータス (`status=done`) と各結果ファイルの GCS URI を記録する。
9.  **結果表示:** Flutter Web は Firestore の `sessions/{docId}` を `onSnapshot` で監視。ステータスが `done` になったら GCS から結果ファイルを取得し、UI に表示する。
10.  **エラーハンドリング:**
   - アップロード失敗、音声処理エラー、Gemini API エラー発生時は、ユーザーにエラーダイアログを表示し、エラー内容を明示する。
   - 必要に応じてリトライや再アップロードの案内も行う。

### 制約条件

- アップロード可能な音声ファイルは最大 15 分まで。
- 対応音声形式: MP3, WAV (16kHz mono 推奨)。
- 対応プラットフォーム: Flutter Web。
- 話者分離は男性(👨)、女性(👩)の 2 名を基本とする。
- AI フィードバックは最大 5 個まで表示。

## 📊 データ要件

- **入力:**
  - 音声ファイル (MP3/WAV, max 15min, 16kHz mono 推奨)
  - ログイン情報 (メールアドレス, パスワード)
- **Gemini 生成データ:**
  - **文字起こし (JSON):** ユーザー提供のサンプルイメージに準拠した構造。話題ごとの区切り、開始時間、話者(👨/👩)、発言内容、(任意で)感情タグを含む。
  ```json
  // 例: JSON構造のイメージ (あくまで一例)
  {
    "transcripts": [
      {
        "topic": "待ち合わせ・挨拶",
        "startTime": "0:00",
        "turns": [
          {
            "speaker": "👨",
            "utterance": "あの、こんばんは。",
            "timestamp": 0
          },
          {
            "speaker": "👩",
            "utterance": "こんばんは。(笑)",
            "emotion": "驚き、照れ",
            "emotion_rationale": "声をかけられてすぐに笑い出す声",
            "timestamp": 3
          }
          // ...
        ]
      },
      {
        "topic": "遅刻の理由",
        "startTime": "0:56",
        "turns": [
          // ...
        ]
      }
      // ...
    ]
  }
  ```
  - **非言語情報分析 (Markdown):** ユーザー提供のプロンプト指示に準拠した Markdown 形式。感情分析 (話者 B)、会話の間、テンション分析 (話者 B) のセクションを含む。
  - **AI フィードバック (Markdown):** ユーザー提供のプロンプト指示に準拠した Markdown 形式。「良かった点」「改善提案」のサマリーを含む。分析観点に基づき、具体的な時間や発言を引用。
- **Firestore:**
  - `users/{userId}`: ユーザー情報 (認証と紐づく)
  - `sessions/{sessionId}`: 各分析セッションのメタデータ。
    - `userId`: (FK to users collection)
    - `status`: (e.g., 'processing', 'done', 'error')
    - `createdAt`: Timestamp
    - `audioSourceUri`: (GCS or Files API URI of the original audio)
    - `transcript`: {
      "transcripts": [
      {
      "topic": "待ち合わせ・挨拶",
      "startTime": "0:00",
      "turns": [
      {
      "speaker": "👨",
      "utterance": "あの、こんばんは。",
      "timestamp": 0
      },
      {
      "speaker": "👩",
      "utterance": "こんばんは。(笑)",
      "emotion": "驚き、照れ",
      "emotion_rationale": "声をかけられてすぐに笑い出す声",
      "timestamp": 3
      }
      ]
      }
      ]
      }
    - `nonVerbalAnalysis`: {
      "emotionAnalysis": {
      "speakerB": {
      "timeline": [
      {
      "timestamp": 0,
      "emotion": "緊張",
      "intensity": 80
      }
      ]
      }
      },
      "conversationGaps": [
      {
      "startTime": 0,
      "endTime": 3,
      "duration": 3,
      "type": "自然な間"
      }
      ],
      "tensionAnalysis": {
      "speakerB": {
      "timeline": [
      {
      "timestamp": 0,
      "tension": 70
      }
      ]
      }
      }
      }
    - `feedback`: {
      "positivePoints": [
      {
      "point": "自然な挨拶",
      "timestamp": 0,
      "rationale": "相手の反応が良好"
      }
      ],
      "improvementPoints": [
      {
      "point": "会話の間の活用",
      "timestamp": 3,
      "suggestion": "もう少し間を取る"
      }
      ]
      }
    - `errorMessage`: (Optional, if status is 'error')
- **Cloud Storage (GCS):**
  - アップロードされた元音声ファイル (または Vertex AI Files API を使用)

## 🔄 インタラクション

- **Frontend (Flutter Web) ↔ Backend (Firebase/GCP):**
  - **認証:** Firebase Authentication
  - **ファイルアップロード:** Vertex AI Files API or Cloud Storage (via Signed URLs)
  - **処理トリガー:** Eventarc (Files API/GCS event → Cloud Run)
  - **結果取得:** Firestore (`onSnapshot`), Cloud Storage (for result files)
- **Backend (Cloud Run) ↔ GCP Services:**
  - **ファイル取得/保存:** Vertex AI Files API / Cloud Storage
  - **AI 分析:** Vertex AI Gemini API
  - **ステータス更新:** Firestore
- **音声処理パイプライン:**
  1. Files API/GCS (Upload)
  2. Eventarc (Trigger)
  3. Cloud Run (Orchestration, Preprocessing, Gemini Calls, Postprocessing)
  4. Gemini API (STT, Non-verbal analysis, Feedback generation)
  5. Cloud Storage (Result storage)
  6. Firestore (Metadata and status update)

## ❓ 未解決の質問

- 非言語情報の折れ線グラフについて、縦軸の具体的な指標（例: 0-100 の盛り上がりスコアなど）と算出ロジックの詳細定義。
- Gemini API 呼び出しの詳細: 文字起こし、非言語分析、フィードバック生成を 1 回の呼び出しで実現可能か、複数回に分ける場合の具体的なプロンプトと処理フロー。
