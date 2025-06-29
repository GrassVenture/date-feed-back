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
3.  **ドキュメント作成:** Firebase Storage のファイル URL を Firestore のフィールドとして持たせる。
4.  **API リクエスト:**
5.  **処理開始:** ファイルアップロード完了をトリガー (Eventarc) として Cloud Run ジョブが起動。
6.  **音声分割 (必要な場合):** Cloud Run が音声ファイルをダウンロードし、15 分を超える場合は ffmpeg で最初の 15 分チャンクを抽出。
7.  **Gemini 分析:** Cloud Run が Gemini 2.5 Pro を呼び出し、指定されたプロンプトに基づき「文字起こし (JSON)」「非言語情報分析 (Markdown)」「AI フィードバック (Markdown)」を生成させる。(注: プロンプトに応じて複数回の呼び出しが必要になる可能性がある)
8.  **結果保存:** Cloud Run は生成された結果 (文字起こし JSON、非言語分析 Markdown、フィードバック Markdown) を GCS に保存し、Firestore の `sessions/{docId}` ドキュメントに処理ステータス (`status=done`) と各結果ファイルの GCS URI を記録する。
9.  **結果表示:** Flutter Web は Firestore の `sessions/{docId}` を `onSnapshot` で監視。ステータスが `done` になったら GCS から結果ファイルを取得し、UI に表示する。
10. **エラーハンドリング:**

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
  - `sessions/{sessionId}`: 各分析セッションのメタデータ。 - `userId`: (FK to users collection) - `status`: (e.g., 'processing', 'done', 'error') - `createdAt`: Timestamp - `storageUrl`: (GCS or Files API URI of the original audio) - `conversationTranscript`: {
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
    } - `femaleEmotionGraph`: {
    "graph_data": {
    "timestamps": ["0:03", "0:10", "0:18", "0:26", "0:35", "0:42", "0:48", "0:57", "1:18", "1:24", "1:29", "2:13", "2:19", "2:28", "3:00", "3:07", "3:15", "3:20", "4:24", "4:32", "4:38", "5:12", "5:17", "5:25"],
    "tension_scores": [4, 4, 0, 4, 1, 2, 3, 3, 3, 4, 2, 0, 3, 3, 3, 3, 1, 3, -1, 4, 4, -2, 3, -1]
    }
    } - `conversationFeedback`: {
    "feedback_analysis": {
    "total_score": 78
    },
    "detailed_scores": {
    "1_tension_voice_nonverbal": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "テンションが高い",
    "evidence": "[0:00] 👨「あの、こんばんは 🤪」から始まり、全体的に明るい声のトーンで会話を進められています。",
    "time_reference": "0:00"
    },
    {
    "point": "女性のテンションに合わせて声のトーンを調整",
    "evidence": "[0:37] 👨「嘘です 🤣」のように、女性の驚きに対してユーモアを交えて明るく返せています。",
    "time_reference": "0:37"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "一部で声が小さくなる場面",
    "evidence": "[2:10] 👨「お仕事は何されてるんですか？ 🤔」の部分で、少し声が小さく聞こえる可能性があります。",
    "suggestion": "重要な質問の際は、より明確で聞き取りやすい声量を心がけましょう。",
    "time_reference": "2:10"
    }
    ]
    },
    "2_reaction": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "女の子発言に即時にリアクションを返せている",
    "evidence": "[0:10] 👩「びっくりした 😂」に対し、すぐに[0:06] 👨「どうしたん 😳」と反応できています。",
    "time_reference": "0:06-0:10"
    },
    {
    "point": "感情こもってリアクションしている",
    "evidence": "[2:16] 👨「すごい！大変そうですね 🫶」など、相手の職業に対して心からの尊敬を込めてリアクションしています。",
    "time_reference": "2:16"
    },
    {
    "point": "相手が笑ってほしいところで大きく笑う",
    "evidence": "[4:32] 👩「自分で言っちゃダメです！ 😂」に対して、適切に笑いで返せています。",
    "time_reference": "4:32"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "相槌のバリエーションを増やす",
    "evidence": "「うん」「そうですね」などの基本的な相槌が多く見られます。",
    "suggestion": "「なるほど！」「それは面白いですね」など、より感情を込めた相槌を使いましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "3_conversation_pause_silence": {
    "score": 3,
    "max_score": 5,
    "good_points": [
    {
    "point": "沈黙が発生した場合、自分から新しい話題を振って解消",
    "evidence": "沈黙の後に[2:10] 👨「お仕事は何されてるんですか？ 🤔」と新しい話題を提供しています。",
    "time_reference": "2:10"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "気まずい沈黙の回避",
    "evidence": "[4:24] 👩「うーん(...) 優しい人がいいですね 🤔」の後の 3 秒間の沈黙。",
    "suggestion": "相手が考え込んでいる時は、プレッシャーを与えずに軽い話題で場を和ませましょう。",
    "time_reference": "4:24"
    }
    ]
    },
    "4_topic_development_questioning": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "共感だけでなく、話題を広げている",
    "evidence": "[3:04] 👨「そうなんです！最近何か見ました？ 😆」のように、映画の話題から具体的な質問に展開しています。",
    "time_reference": "3:04"
    },
    {
    "point": "相手の趣味や好きな話題を深掘り",
    "evidence": "[0:48] 👩「そうなんですね！何がおすすめですか？ 😊」に対して適切に答え、会話を発展させています。",
    "time_reference": "0:48"
    },
    {
    "point": "相手を含んだ話題展開",
    "evidence": "[3:20] 👩「わかります！ラストシーンで泣きそうになりました 🤗」に対して共感し、会話を深めています。",
    "time_reference": "3:20"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "より具体的な質問を増やす",
    "evidence": "一般的な質問が多く、相手の個性を引き出す質問が少ない。",
    "suggestion": "「なぜそう思ったの？」「どんな気持ちだった？」など、感情や価値観を引き出す質問を増やしましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "5_deep_dive": {
    "score": 3,
    "max_score": 5,
    "good_points": [
    {
    "point": "価値観まで引き出している",
    "evidence": "[2:19] 👩「夜勤もあるし、確かに大変ですけど(...) やりがいはあります 😌」から仕事に対する価値観を聞き出せています。",
    "time_reference": "2:19"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "表面的な質問で終わることが多い",
    "evidence": "職業について聞いた後、より深い動機や背景について掘り下げていません。",
    "suggestion": "「なぜ看護師になろうと思ったの？」など、動機や背景まで聞いてみましょう。",
    "time_reference": "2:13-2:32"
    },
    {
    "issue": "感情の映像化まで至っていない",
    "evidence": "具体的な場面や情景を想像できるような質問が少ない。",
    "suggestion": "「その時どんな気持ちだった？」「どんな景色だった？」など、相手の体験を映像化する質問を増やしましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "6_self_assertion_empathy": {
    "score": 3,
    "max_score": 5,
    "good_points": [
    {
    "point": "自分の価値観を明確に主張",
    "evidence": "[2:26] 👨「尊敬します 🧑‍🏫」のように、人を大切にする価値観を示しています。",
    "time_reference": "2:26"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "より深い価値観の共有",
    "evidence": "表面的な共感にとどまり、自分の軸を明確に伝える場面が少ない。",
    "suggestion": "相手の話を聞いた上で、「僕はこう考えているんだ」という自分の価値観をもっと積極的に伝えましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "7_affirmation_reframing": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "女性の発言を肯定的に受け止めている",
    "evidence": "[1:29] 👩「そんなことないです(...) でもありがとうございます 😅」に対して、優しく褒め続けている。",
    "time_reference": "1:20-1:29"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "リフレーミングの機会を逃している",
    "evidence": "相手のネガティブな発言をポジティブに捉え直す機会があったが活用していない。",
    "suggestion": "相手が自分を否定的に話した時は、別の角度から魅力的に捉え直して伝えましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "8_accommodation": {
    "score": 3,
    "max_score": 5,
    "good_points": [
    {
    "point": "必要な場面で自分の意見も伝えている",
    "evidence": "[4:30] 👨「僕、優しいですよ 🤪」のように、自分の特徴をアピールしています。",
    "time_reference": "4:30"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "過度な同調を避ける",
    "evidence": "全体的に相手に合わせすぎる傾向があり、自分の個性が薄れる場面がある。",
    "suggestion": "適度に自分の意見や価値観を主張し、対等な関係を築きましょう。",
    "time_reference": "全体"
    },
    {
    "issue": "褒められた時の反応",
    "evidence": "褒められた際に謙遜しすぎる場面がある。",
    "suggestion": "褒められた時は素直に受け取り、自信を持って振る舞いましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "9_affection_expression": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "根拠を出して好意を伝えている",
    "evidence": "[1:20] 👨「写真で見るより綺麗ですね 🥰」と具体的な理由を添えて褒めています。",
    "time_reference": "1:20"
    },
    {
    "point": "特別感を演出している",
    "evidence": "相手を特別扱いする発言で好意を示しています。",
    "time_reference": "1:20-1:29"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "より具体的な根拠",
    "evidence": "好意を伝える際の根拠がやや表面的。",
    "suggestion": "外見だけでなく、内面や行動に対する具体的な理由を添えて好意を伝えましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "10_commonality_exclusivity": {
    "score": 5,
    "max_score": 5,
    "good_points": [
    {
    "point": "価値観や人生観など深い話題で共通点",
    "evidence": "[3:12-3:20] 映画の話題で「えっ！俺も見ました！ 😳」「めっちゃ良かったですよね 😆」と深い共感を示しています。",
    "time_reference": "3:12-3:20"
    },
    {
    "point": "共通点を特別な繋がりとして強調",
    "evidence": "[3:25] 👨「僕も同じです！(...沈黙) 🤗」で感動を共有し、特別な瞬間を作り出しています。",
    "time_reference": "3:25"
    }
    ],
    "improvement_suggestions": []
    },
    "11_compliments": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "内面まで褒めている",
    "evidence": "[2:16] 👨「すごい！大変そうですね 🫶」で職業への尊敬を示し、[2:26] 👨「尊敬します 🧑‍🏫」で内面を褒めています。",
    "time_reference": "2:16-2:26"
    },
    {
    "point": "特別感を伝える褒め",
    "evidence": "[1:20] 👨「写真で見るより綺麗ですね 🥰」で他との比較を含めて褒めています。",
    "time_reference": "1:20"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "具体性の向上",
    "evidence": "褒める際の具体的な理由をもっと詳しく伝える余地がある。",
    "suggestion": "「なぜそう思うのか」「どこが具体的に素敵なのか」をより詳しく説明しましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "12_value_proof_scarcity": {
    "score": 3,
    "max_score": 5,
    "good_points": [
    {
    "point": "自分の経験を自然にアピール",
    "evidence": "[2:32] 👨「そうです。エンジニアやってます 🙂」で職業を自然に伝えています。",
    "time_reference": "2:32"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "より具体的な価値の提示",
    "evidence": "自分の強みや経験をもっと具体的にアピールする機会があった。",
    "suggestion": "趣味や特技、面白い経験談などを通じて自分の魅力をより具体的に伝えましょう。",
    "time_reference": "全体"
    },
    {
    "issue": "ギャップの演出",
    "evidence": "真面目な一面とふざけた一面のギャップを作る機会を逃している。",
    "suggestion": "普段の自分と違う一面を見せることで、魅力的なギャップを演出しましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "13_humor_teasing": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "明るい声や笑いながら冗談を言っている",
    "evidence": "[0:37] 👨「嘘です 🤣」で場を和ませる冗談を明るく伝えています。",
    "time_reference": "0:37"
    },
    {
    "point": "相手が返しやすい例えやツッコミ",
    "evidence": "[4:30] 👨「僕、優しいですよ 🤪」に対して[4:32] 👩「自分で言っちゃダメです！ 😂」と返しやすい流れを作っています。",
    "time_reference": "4:30-4:32"
    },
    {
    "point": "相手が楽しそうに笑っている",
    "evidence": "女性が 😂🤣😅 などの笑いの絵文字で反応しており、ユーモアが伝わっています。",
    "time_reference": "全体"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "いじりのバリエーション",
    "evidence": "軽いいじりやユーモアの種類をもっと増やせる余地がある。",
    "suggestion": "相手の発言や行動に対して、もっと多様な角度からユーモアを交えてみましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "14_future_talk": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "未来トークが自然で共感を得ている",
    "evidence": "[4:35] 👨「じゃあ今度証明させてください 😏」[5:17] 👩「ありがとうございます(...) 今度は私が 😌」で次回への期待を作っています。",
    "time_reference": "4:35, 5:17"
    },
    {
    "point": "特別感を演出",
    "evidence": "[5:28] 👨「今度も楽しみにしてます 🥰」で次回への期待を表現しています。",
    "time_reference": "5:28"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "より具体的な提案",
    "evidence": "「今度」という表現が多いが、具体的な提案が少ない。",
    "suggestion": "「今度映画を一緒に見に行こう」など、より具体的な未来の提案をしてみましょう。",
    "time_reference": "全体"
    }
    ]
    },
    "15_escort_manners": {
    "score": 4,
    "max_score": 5,
    "good_points": [
    {
    "point": "女性への配慮ができている",
    "evidence": "[5:10] 👨「今日はごちそうします 😊」で女性への気遣いを示しています。",
    "time_reference": "5:10"
    },
    {
    "point": "丁寧な態度",
    "evidence": "全体を通して丁寧な言葉遣いで女性が安心できる雰囲気を作っています。",
    "time_reference": "全体"
    }
    ],
    "improvement_suggestions": [
    {
    "issue": "より先回りした気遣い",
    "evidence": "基本的な気遣いはできているが、より先回りした配慮ができる余地がある。",
    "suggestion": "相手が困る前に「寒くない？」「歩く速度大丈夫？」など先回りして気遣いましょう。",
    "time_reference": "全体"
    }
    ]
    }
    },
    "overall_summary": {
    "strengths": [
    "映画の話題で深い共通点を見つけ、特別な繋がりを演出できた（3:12-3:25）",
    "相手の発言に対して適切なリアクションとユーモアで場を和ませることができた",
    "女性への基本的な気遣いとマナーが身についている",
    "次回のデートへの期待を自然に作り出すことができた"
    ],
    "areas_for_improvement": [
    "より深い価値観や感情を引き出す質問力の向上",
    "自分の魅力や経験をより具体的にアピールする",
    "相手のネガティブな発言をポジティブにリフレーミングするスキル",
    "沈黙を効果的に活用し、気まずさを回避する能力"
    ],
    "next_steps": [
    "「なぜそう思うの？」「どんな気持ちだった？」など感情を引き出す質問を増やす",
    "自分の趣味や特技、面白い経験談を準備しておく",
    "相手が自分を否定的に話した時のリフレーミングパターンを学ぶ",
    "2-3 秒の沈黙を恐れず、相手のペースに合わせることを意識する"
    ]
    }
    } - `errorMessage`: (Optional, if status is 'error')
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
