# Wren audio setup

> One-time generation of Wren's voice via ElevenLabs. Pre-generated audio
> files ship in the bundle and play instantly with no latency. Until files
> exist, the app falls back to iOS TTS automatically.

## Why

iOS `AVSpeechSynthesizer` (the default voice) sounds robotic and has a
~300-500ms first-utterance delay. Pre-generated audio files from a
high-quality TTS service like ElevenLabs play instantly and sound
genuinely human.

This is a **one-time** setup. After files are bundled, no API calls, no
ongoing cost, no network at runtime. To update phrases later, edit
`WrenVoice.swift` and `Tools/generate_wren_audio.swift` (keep them in
sync), then re-run the generation script — only new phrases get
generated; existing files are skipped.

## Setup

### 1. Get an ElevenLabs API key

1. Sign up at https://elevenlabs.io/
2. Free plan gives 10K chars/month — more than enough for a one-time
   generation of all Wren phrases (~7,500 chars). Pay-as-you-go after
   that is $0.30/1K chars.
3. Go to your profile → API key → copy it.

### 2. Pick a voice

1. Browse ElevenLabs's voice library or use the default voices.
2. Listen to a few — Wren's brand is warm, plainspoken, soft but not
   saccharine. Voices like "Sarah," "Charlotte," "Lily," or any of
   their "soft" / "natural" presets fit. You can also clone a voice
   if you have a recording.
3. Copy the voice ID (in the URL when previewing a voice, or via
   their voice library API).

### 3. Run the generation script

From the repo root:

```bash
export ELEVENLABS_API_KEY="your_key_here"
export ELEVENLABS_VOICE_ID="your_voice_id_here"
./Tools/generate_wren_audio.swift
```

The script:
- Hits the ElevenLabs TTS endpoint for each phrase in `WrenVoice.swift`
- Saves audio files (mp3, ~10-30 KB each) into `Quell/Quell/WrenAudio/`
  with hash-based filenames matching `WrenSpeaker`'s lookup
- Skips files that already exist (idempotent — safe to re-run)
- Rate-limits gently with a 250ms pause between calls
- Prints `✓` for each generated file, `✗` for failures, summary at the
  end

A run of the full phrase set takes ~1-2 minutes and uses about 7,500
characters of API quota.

### 4. Build and run

The Quell project uses Xcode 16's synchronized root group, so files
dropped into `Quell/Quell/WrenAudio/` are automatically picked up by
the next build. No project file edits needed.

Verify on the simulator: trigger any Wren-voiced surface (co-regulation,
mood protocol, exercise, closing line). Audio should play instantly with
no latency. If a phrase wasn't generated, that one falls back to iOS
TTS automatically.

## Updating phrases

When you edit Wren's copy:

1. Update the relevant section in `Quell/Quell/DesignSystem/WrenVoice.swift`
2. Mirror the same edit in `Tools/generate_wren_audio.swift`
3. Re-run the generation script — only the new/changed phrases are
   generated. Old (now-unused) audio files stay in the bundle but
   nothing references them; you can periodically prune by deleting
   files in `WrenAudio/` whose hash isn't in the current phrase set.

## Costs

- **One-time generation:** ~$0 on the free plan (10K chars/month
  covers it). Pay-as-you-go after that: ~$2-3 per full regen if you
  blow through the free tier.
- **Voice cloning** (optional): If you want to clone Bailey's voice or
  a specific person's voice, ElevenLabs's instant voice cloning is on
  the $5/mo Starter plan and uses any clean ~1-min audio sample.
- **Premium voice subscription** (only if regenerating frequently):
  $5-22/mo. Not needed for the typical workflow.

## Troubleshooting

**Audio still sounds like default TTS.** Files weren't bundled. Check
that `Quell/Quell/WrenAudio/` contains `.mp3` files. Build the app —
Xcode should pick them up. Run on simulator/device.

**Some phrases play TTS, others play files.** Hash mismatch — phrase
text in `WrenVoice.swift` doesn't exactly match what was sent to
ElevenLabs. Re-run the generation script after syncing `WrenVoice.swift`
and `Tools/generate_wren_audio.swift`.

**Script fails with HTTP 401.** API key is wrong or expired. Re-copy
from ElevenLabs.

**Script fails with HTTP 429.** Rate-limited. The script pauses 250ms
between calls; if your account has a stricter limit, increase the sleep
duration in the script.
