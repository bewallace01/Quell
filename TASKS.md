# TASKS.md

> The live work list. Each phase has slices. Each slice has tasks. We finish a slice end-to-end before starting the next one. We do not skip ahead.
>
> Status legend: `[ ]` not started · `[~]` in progress · `[x]` done · `[!]` blocked · `[-]` skipped/descoped

---

## Phase 0: Foundation

**Goal:** App launches on Bailey's phone, shows a placeholder screen with the Quell brand, and the design system is in place.

**Done when:** You can hold your phone, open the Quell app, see the midnight palette, see the typography, and feel "yeah, this is it."

### Slice 0.1: Pre-flight setup

- [x] Confirm Mac is ready (latest macOS, enough disk space)
- [x] Install latest stable Xcode from the App Store
- [x] Sign into Xcode with Apple ID
- [x] Decide whether to enroll in Apple Developer Program now ($99/year) or wait until first device test
- [x] Create a GitHub (or other) repo named `quell` and initialize locally

### Slice 0.2: Xcode project creation

- [x] Create new Xcode project: iOS App, SwiftUI, Swift, name "Quell"
- [x] Bundle identifier: `com.lightspacelabs.quell`
- [x] Minimum deployment: iOS 17.0
- [x] Confirm project builds and runs in simulator with default Hello World
- [x] First commit to git
- [x] Add the three planning files (`QUELL_PROJECT_BRIEF.md`, `MEMORY.md`, `TASKS.md`) to project root
- [x] **Visual checkpoint:** simulator shows default screen, no errors

### Slice 0.3: Design token system

- [x] Create `Quell/DesignSystem/` folder in project
- [x] Create `QuellColors.swift` with all color tokens from the brief, as Color extensions
- [x] Create `QuellTypography.swift` with all type tokens as Font extensions
- [x] Create `QuellSpacing.swift` with spacing constants
- [x] Create `QuellMotion.swift` with animation/duration constants
- [x] Create a small `TokenPreview` SwiftUI view that displays every color, font, and spacing value side by side
- [x] **Visual checkpoint:** the token preview screen renders all tokens correctly. Bailey looks at it and approves the palette in context.

### Slice 0.4: App shell and first real screen

- [x] Replace default ContentView with a `QuellApp` root view
- [x] Set the app's background to `quellMidnight`
- [x] Create `PlaceholderHomeView.swift` showing just the word "quell" in display font, centered, on midnight background
- [x] Add subtle fade-in animation on appear *(in code; iOS launch sequence currently masks the visual; revisit when this pattern lives somewhere without a launch boundary)*
- [x] **Visual checkpoint:** the app launches, shows "quell" softly fading in on a deep slate background. Feels quiet, intentional.

### Slice 0.5: First device test (optional but recommended)

- [ ] Enroll in Apple Developer Program if not done
- [ ] Connect iPhone, trust the Mac
- [ ] Build and run on actual device
- [ ] **Visual checkpoint:** Bailey holds the phone, opens the app, sees the brand. This is the moment to feel whether the foundation is right.

### Phase 0 Closeout

- [x] Update `MEMORY.md` with Phase 0 summary
- [x] Update Decisions Log in brief with anything new
- [x] Take a screenshot of the placeholder screen for posterity
- [ ] Decide: ready for Phase 1?

---

## Phase 1: Home Screen

**Goal:** The doorway. The animated breathing shape, "right now i'm…" prompt, and four word-stones (Steady, Wobbling, In it, Need company).

**Done when:** You open the app, see the breathing shape pulsing at a real breath cycle, see the four word-stones floating, and tapping any one of them navigates to a placeholder destination.

### Slice 1.1: Breathing shape

- [x] Create `BreathingShape.swift` — a custom SwiftUI view (lives in `Quell/Quell/Components/`)
- [x] Render a soft circle/orb using a radial gradient: ember (0.0) → dawn (0.22) → moon (0.5) → midnight (1.0). Stops weighted so the warm core lives inside ~22% of the radius and blue dominates from 50% out
- [x] Animate scale (0.72 → 1.05) and opacity (0.5 → 0.95) in a 4s inhale / 6s exhale loop using `quellEaseGentle`, with a 0.4s hold at peak and 1.2s rest at trough
- [x] Apply `.blur(radius: 6)` before `.scaleEffect` so the orb is slightly more diffuse at peak inhale and more defined at trough
- [x] Make sure the animation is continuous and never jarring
- [x] **Visual checkpoint:** stare at it for 30 seconds. Does it feel calming or annoying? Adjust until calming.
- [x] Wire `BreathingShape` into `PlaceholderHomeView` as the home centerpiece (replaces the "quell" wordmark)

### Slice 1.2: "Right now i'm…" prompt

- [x] Add the prompt "right now i'm…" (lowercase, horizontal ellipsis) above the breathing shape in `quellTitle` (Fraunces 24pt light). Stepped down from `quellDisplay` 36pt after stare-test felt too large.
- [x] Use `quellCream` color
- [x] Generous spacing above and below — `quellSpace8` (64pt) between prompt, orb, and word-stones region
- [x] Subtle fade-in on app launch, delayed 0.6s after the orb begins fading in
- [x] **Visual checkpoint:** prompt feels like a gentle invitation, not a question being demanded.

### Slice 1.3: The four word-stones

- [x] Create `WordStone.swift` in `Quell/Quell/Components/`. Uses new `.quellStone` token (Fraunces 20pt light, added to `QuellTypography.swift` between `quellTitle` and `quellHeadline`). No chrome at rest — soft floating word.
- [x] Layout: four word-stones below the breathing shape — Steady · Wobbling · In it · Need company. Initially two HStack rows; switched to `LazyVGrid` with two flexible columns + `quellSpace7` horizontal padding so labels of different widths column-align cleanly.
- [x] Each tap: soft haptic via `.sensoryFeedback(.impact(flexibility: .soft, intensity: 0.6))`, scale to 0.96 during press via custom `StonePressStyle`, brief `quellGlow` capsule background (opacity 0.18, blurred) + shadow (opacity 0.5, radius 16) that fades out over `quellDurSlow` after `quellDurFast`.
- [x] Touch targets: 44pt min via `.frame(minWidth: 44, minHeight: 44)` plus `quellSpace5`/`quellSpace3` padding.
- [x] **Visual checkpoint:** tap each one. Does the response feel warm? Or does it feel like a button click? Adjust.

### Slice 1.4: Placeholder routing

- [x] Each word-stone navigates to `StoneDestinationView(word:)` showing just the word in `quellDisplay` (Fraunces 36pt light), centered on `quellMidnight`. Word fades in 0.2s after the surface materializes — moment of held space, then the word arrives.
- [x] Soft dissolve transition via `.transition(.opacity)` with `quellEaseSlow` over `quellDurSlow`. State-driven view swap (`@State var selected: String?`) rather than `NavigationStack` — the default `NavigationStack` push is a slide and customizing it fights the framework. Will introduce `NavigationStack` with a custom transition theme in Phase 2 when there's real depth to manage.
- [x] Tap-anywhere dismiss on the destination — no chrome, most water-like for a placeholder. Will revisit when destinations have real content (Phases 2-6).
- [x] Home view stays alive in the background (opacity-toggled rather than swapped) so its staggered fade-in cadence only plays on first launch; return-from-destination is an opacity flip, not a re-stage.
- [x] **Visual checkpoint:** the navigation feels like water. No sharp edges.

### Phase 1 Closeout

- [x] Update MEMORY.md
- [ ] Vibes check: open the app cold and use it for 60 seconds. Does it feel like Quell?
- [ ] Decide: ready for Phase 2?

---

## Phase 2: Urge Flow

**Goal:** The heart of the app. The "In it" path leads to 60-second co-regulation, then the Fork (Body / Mood / Don't know), then one full route end-to-end (Mood → Anxious), then the Wave Check.

**Done when:** A real user can tap "In it" during a real urge and the app actually helps them through the next 5-10 minutes.

### Slice 2.1: The 60-second co-regulation screen

- [x] On "In it" tap, route via enum-based `Destination` (`.coRegulation` case in `PlaceholderHomeView`) to a new `CoRegulationView`. Cross-fade via `.transition(.opacity)` with `quellEaseSlow` over `quellDurSlow` (matches the spec's 800ms). Background is the new `quellAbyss` token (#040714) — deeper than `quellMidnight`, the held interior of the urge flow.
- [x] Display "i'm here.\nbreathe with me." in `quellDisplay` (Fraunces 36pt light) with `multilineTextAlignment(.center)`. Forced two-line layout. Fades in at t=1.0s.
- [x] Show `BreathingShape(size: 280)` — 40% larger than home's 200pt. Fades in at t=1.6s.
- [x] No buttons for first 8 seconds.
- [x] After 8 seconds, "stay" and "skip ahead" `WordStone`s fade in. "stay" hides them and re-surfaces after 12s so the user isn't stuck without an exit; "skip ahead" calls `onExit` (returns to home; will route to Fork in Slice 2.3).
- [x] Bonus fix during this slice: added `.fixedSize(horizontal: true, vertical: false)` to `WordStone`'s Text so HStack contexts don't truncate the label (was hitting "stay" → "st…").
- [x] **Visual checkpoint:** time it. Sit through the 8 seconds. Does the pause feel right or punishing?

### Slice 2.2: Wren's first voice (text-based)

- [x] Create `WrenLine.swift` in `Quell/Quell/Components/` — a styled text component for Wren's voice. Renders one phrase at a time in `quellDisplay` (Fraunces 36pt light), `quellCream`, multilineTextAlignment center. Component owns its own rotation via `.task`.
- [x] Implement a small set of co-regulation phrases that rotate. Initial set: `still here.` / `yeah, this is hard.` / `no rush.` / `we can wait.` / `it'll pass. it always does.` / `just this.` First draft used therapy-stock affirmations (`i see you`, `your body is doing the work`, etc.) but they read as cheesy; rewrote toward friend-on-the-floor voice — observational, plainspoken, no self-announcing "i" frames.
- [x] Phrases display one at a time during the breathing loop. Interval: 22 seconds (~2 full breath cycles of 11.6s).
- [x] Slow fade between phrases via `quellEaseSlow` over `quellDurSlow` (0.8s).
- [x] **Visual checkpoint:** read the phrases as a stranger would. Do they feel warm or clinical?

### Slice 2.3: The Fork

- [x] Create `ForkView.swift` in `Quell/Quell/Screens/`. Three soft circular shapes (`quellMoon` → `quellMidnight` radial gradient, 100pt diameter, `.blur(radius: 3)`) in a triangle: Body at offset (0, -120), Mood at (-90, 80), Don't know at (90, 80). Background is `quellAbyss` to keep the urge-flow tonal world.
- [x] `ForkChoice` enum (`.body` / `.mood` / `.dontKnow`) with raw String labels. `ForkView.onCommit` fires the chosen case to the parent.
- [x] **Deviated from spec.** Original spec was "tap reveals label, second tap commits" but Bailey called the discovery friction-y in stare-test. Shipped: **labels always visible, single tap commits.** Tap fires a soft-impact haptic via `.sensoryFeedback`, scales the option down to 0.94 during press via custom `ForkPressStyle`, and adds a brief `quellGlow` shadow on the tapped shape before the cross-fade to the destination.
- [x] All three options fade in together over `quellDurSlow` after a 0.3s delay (so the cross-fade from co-regulation has time to settle first).
- [x] Routing: extended `Destination` enum with `.fork`. Renamed `CoRegulationView.onExit` to `onAdvance` (its semantic is now "advance to Fork", not "exit to home"). `ForkView.onCommit` routes each choice to a `StoneDestinationView` placeholder; Phases 4 (Body) and 6 (mood/scan) will replace those.
- [x] **Visual checkpoint:** does the three-option layout feel like a real choice or overwhelming? Test with no labels first.

### Slice 2.4: Mood route — Anxious protocol

- [x] `MoodView.swift` in `Quell/Quell/Screens/`. Six `WordStone`s in a 2×3 `LazyVGrid` (Anxious / Lonely / Tired / Bored / Numb / Rage), `quellAbyss` background, header "what is it?" in `quellTitle`. `MoodChoice` enum with rawValue labels. Single-tap commits.
- [x] Anxious tap routes to `AnxiousProtocolView.swift` — `BreathingShape(size: 280)` + `WrenLine` rotating 6 protocol phrases on a 30s interval (slower than co-reg's 22s for more reflective space). Phrases mix physiological-sigh guidance and grounding cues: `double inhale through your nose.` / `long exhale through your mouth.` / `again. another sigh.` / `feel your feet on the floor.` / `name three things you can see.` / `the spike is coming down.`
- [x] Breath visual reuses default `BreathingShape` timing — Wren's text does the actual sigh-pattern cueing. Parameterizing `BreathingShape` to support a literal sigh visual (double-inhale-long-exhale shape) was a bigger lift; deferred until stare-test feedback says it's needed.
- [x] "this isn't helping" `WordStone` fades in at t=1.5s, persistent. Tap routes back to Fork via `onTryElse`.
- [x] Routing: extended `Destination` enum with `.mood` and `.anxiousProtocol`. Other 5 mood options (Lonely / Tired / Bored / Numb / Rage) route to `StoneDestinationView` placeholders (Phases 6.1–6.5 will replace each).
- [x] **Visual checkpoint:** do the full protocol. Does it actually feel like it would help during real anxiety?

### Slice 2.5: The Wave Check

- [x] `AnxiousProtocolView` gets an `onAdvance` callback and a `duration: Duration = .seconds(120)` parameter. After 120s the protocol auto-routes to Wave Check via `Task { try? await Task.sleep(for: duration); onAdvance() }`. (For dev testing the auto-advance path, temporarily lower duration to ~15s.)
- [x] `WaveCheckView.swift` in `Screens/`. Background `quellMidnight` (lighter than `quellAbyss` — surfacing from the urge-flow interior). Wren prompt: "where is it now?" `SoftSlider` (custom component, see below) for the bigger ← same → smaller axis. Endpoint labels "bigger" / "smaller" in `quellWhisper`, no numbers.
- [x] `WaveResult` enum (`.bigger` / `.same` / `.smaller`). On slider release, value is bucketed (<0.33 = bigger, ≥0.67 = smaller, else same), a brief Wren result line fades in (`okay. we can get more help.` / `let's try something else.` / `you're still here. nice work staying.`) and shows for 2.5s, then `onComplete(result)` fires.
- [x] Branches: `.smaller` → home (debrief is Slice 2.6), `.same` → Fork, `.bigger` → `CoPilotPlaceholderView`.
- [x] `CoPilotPlaceholderView.swift` v1: `quellAbyss` background, "let's escalate." in `quellDisplay`, `WordStone`s for "988 — call" (taps `tel:988` via `openURL`) and "back to home". NAED helpline excluded from v1 — Phase 10.3 builds crisis resources properly with verified numbers.
- [x] `SoftSlider.swift` in `Components/` — custom soft slider with the track rendered as an actual wave. Default iOS `Slider` was too utilitarian; flat capsule + orb thumb still didn't sell the metaphor. Track is now two stroked sine-wave `Path`s (Wave shape with `animatableData`): a primary `quellMoon` line at full amplitude and a softer `quellGlow` line at 70% amplitude offset by π/3 phase for layered depth. Wave amplitude responds live to slider value: `maxAmplitude * (1 - value)`, so dragging toward "smaller" flattens the wave and dragging toward "bigger" amplifies it. Thumb is 28pt with `quellGlow`→`quellMoon` radial gradient, slides horizontally on the centerline, scales to 1.1 + brighter glow shadow during drag. 60pt touch area to give the wave room. `DragGesture(minimumDistance: 0)` so tap-anywhere on the track also commits to that position.
- [x] Routing: extended `Destination` enum with `.waveCheck` and `.coPilot`.
- [x] **Visual checkpoint:** the slider should feel like a feeling, not a survey question.

### Slice 2.6: The Debrief

- [-] ~~Three skippable prompts: trigger, what helped, what to tell future-you~~ — scrapped. Bailey: "the last thing i'd want is to answer questions." The brief's third bullet is the spirit; questions contradict it.
- [-] ~~Save quietly to local storage~~ — no save needed. Phase 8 Pattern Detective captures structured metadata (time, tool, outcome) automatically without prompts.
- [x] Single soft `ClosingLineView` showing "thanks for showing up." for 3.5s, then home. Reusable component (parameterized line) — Phase 5 also uses it with "still here."

### Phase 2 Closeout

- [ ] Update MEMORY.md
- [ ] Run the entire flow from "In it" through Debrief, end-to-end
- [ ] Have someone else (a trusted friend) try it and watch their face
- [ ] Decide: ready for Phase 3?

---

## Phase 3: Wren

**Goal:** Wren feels like a character, not just UI text. Consistent voice across every touchpoint.

### Slice 3.1: Voice and copy system

- [ ] Create `WrenVoice.swift` — a centralized place for all of Wren's lines
- [ ] Categorize lines by context (greeting, co-regulation, debrief, encouragement, escalation)
- [ ] Implement a system to surface the right line at the right time without repetition

### Slice 3.2: Wren's presence design

- [ ] Decide: does Wren have a visual avatar, a signature glow, or just a voice?
- [ ] Implement chosen approach consistently
- [ ] Settings: Wren's tone (warmer / quieter), text-only vs future audio

### Slice 3.3: First-encounter onboarding moment

- [ ] On first app launch, Wren introduces itself softly
- [ ] No long onboarding tour — just a moment, a name, and a presence
- [ ] **Visual checkpoint:** test on a brand-new install. Does Wren feel like meeting someone or like a tutorial?

---

## Phase 4: Sensory Swaps + Body Route

### Slice 4.1: Body route entry

- [x] `BodyRouteView` — "what does your body actually want?" header in `quellTitle`, `quellAbyss` background.
- [x] Five sensory texture squares laid out 3-top + 2-bottom (crunch / cold / warm + sweet / salty), plus "i want food" stone below. `SensorySquare` private component with rounded-rectangle category-specific `LinearGradient`, slight blur + shadow, press-state scale.
- [x] Abstract texture only — no food images. Each category has a token-based gradient (e.g. crunch = ember→midnight, cold = glow→midnight, warm = ember→dawn, sweet = dawn→cream, salty = mist→whisper).

### Slice 4.2: Sensory Swaps content model

- [x] `SensoryCategory` enum (Codable, CaseIterable) and `SensorySwap` struct (id, title, category, isFood, why) in `SensorySwapStore.swift`.
- [x] Seeded with ~20 entries (4 per category) hand-curated. Spec called for 50; v1 starts at ~20 so the feature ships — extending the seed array is grunt work that doesn't need a new slice.
- [x] Stored inline in Swift (`seedSwaps()` static func), not JSON. Bundled JSON adds a build-step dependency for marginal benefit at this size; JSON migration is trivial later if entries grow.

### Slice 4.3: Browse and detail views

- [x] `SensorySwapsView(category:)` handles browse + detail in one view via internal `selected: SensorySwap?` state, cross-faded with `.transition(.opacity)`. Single routing case (`.sensorySwaps(SensoryCategory)`).
- [x] Browse: list of swap rows in soft `quellShade` capsules, each with title + "non-food" tag if applicable.
- [x] Detail: title in `quellDisplay`, why-copy in `quellBody` `quellMist`, "back" + "i'll try this" stones. "i'll try this" closes to home.
- [x] No ratings or favorites.

### Slice 4.4: Eat Anyway entry from Body route

- [x] "i want food" stone on `BodyRouteView` routes to existing `EatAnywayEntryView` (already in Phase 5). The Fork's Body→EatAnyway shortcut is gone; Body now properly enters via the body-route picker.

---

## Phase 5: Eat Anyway Mode

**Goal:** The philosophical centerpiece. Eating becomes data, not failure.

### Slice 5.1: Mindful path

- [x] `MindfulEatView` shows the four guidance lines + "ten minutes" / "skip timer" stones. Tapping "ten minutes" → ambient screen with `BreathingShape(size: 220)`. Tap anywhere or wait 10 min → close.
- [x] `timerDuration: Duration = .seconds(600)` parameterizable for dev testing.
- [x] Closes via `ClosingLineView(line: "still here.")` — no questions, per Bailey's debrief feedback.

### Slice 5.2: Just-eat path

- [x] `JustEatView` — ambient `BreathingShape(size: 220)` + "i'm here when you're ready. / no pressure." Tap anywhere to dismiss.
- [x] Schedules a 20-min local notification ("checking back. still here when you want me.") via `UNUserNotificationCenter`. Permission requested when JustEat starts; denial is silent (screen still works).
- [x] Tap-to-dismiss cancels the pending notification by identifier.

### Slice 5.3: Post-eat debrief

- [-] ~~"How are you?" — single soft prompt~~ — scrapped per Bailey's debrief feedback (no questions after the moment).
- [-] ~~Optional: trigger tag, one line of reflection~~ — scrapped, same reason.
- [x] Both eat-anyway paths close via `ClosingLineView(line: "still here.")`. No food details captured anywhere — preserved.

### Slice 5.4: Eat Anyway access points

- [x] Body fork choice routes to `EatAnywayEntryView` — "sounds good. / want to slow it down?" with "yes, walk me through" / "just eat. i'll check back." stones.
- [ ] Long-press on Wren's presence — deferred. Wren has no visual avatar yet (text only); revisit in Phase 3.2 when Wren's presence design is locked.
- [ ] **This must be the easiest feature to find when someone is going to eat regardless. Test the access path under pressure.**

---

## Phase 6: Remaining Mood Routes + Don't Know

### Slices 6.1–6.5: Mood protocols

- [x] All six moods (incl. Anxious from 2.4) now share a generic `MoodProtocolView(mood:)`. `AnxiousProtocolView.swift` deleted; replaced.
- [x] Mood-specific phrase sets (Wren voice, friend-on-the-floor) and durations: Anxious 120s, Lonely 120s, Tired 240s (4-min power-down per spec), Bored 90s, Numb 120s, Rage 120s.
- [x] Slice 6.5 deviation: somatic shake-off video/animation deferred for v1. The "rage pad" private auto-delete typing pad ships as `RagePadView` — TextField with `tint: quellGlow`, "done" stone clears the text and dismisses, no save anywhere.
- [x] Slice 6.1 deviation: "anchor person" Messages handoff deferred. Future Self voice note already surfaces in co-reg from Phase 7; mood protocols don't surface them yet (could add).
- [x] All mood protocols auto-advance to Wave Check after their duration. "this isn't helping" routes back to Fork.

### Slice 6.6: Don't Know — body scan flow

- [x] `DontKnowScanView` — 6 sequential prompts (head / jaw / chest / stomach / hands / feet), each with tight / neutral / open `WordStone`s.
- [x] Suggestion: most-tight area = stomach → routes to Eat Anyway entry; otherwise → co-regulation breath. User accepts via the Mood/Eat-Anyway flow that follows; explicit confirm prompt deferred.
- [x] Reached from Fork's "Don't know" choice (was a placeholder).

---

## Phase 7: Future Self Voice Notes

### Slice 7.1: Recording UI

- [x] `RecordVoiceNoteView` — state machine (initial → recording → review → denied). `VoiceRecorder` private helper wraps `AVAudioRecorder` (AAC, 44.1kHz mono, 60s hard cap via `record(forDuration:)`). Permission via `AVAudioApplication.requestRecordPermission()` requested only at moment of need.
- [x] Up to 5 notes stored locally. Audio files in `Documents/`, metadata in `UserDefaults` via `VoiceNoteStore`. Over-cap message: "five saved — delete one to record more."
- [x] Date metadata (auto-generated, displayed as "may 2"). Title editing skipped for v1 — date alone is enough.

### Slice 7.2: Playback during urges

- [x] `CoRegulationView` shows a "your voice" stone above stay/skip-ahead **only when `store.hasNotes`**. Tap plays a random note inline via `AVAudioPlayer`; orb keeps animating, Wren keeps rotating. Label flips to "stop" while playing; auto-stops at audio end or on advance/disappear.
- [x] Random selection via `store.random` (`notes.randomElement()`).
- [x] Skip without judgment — same "stop" affordance + tap "skip ahead" cancels playback before advancing.

### Slice 7.3: Management

- [x] `VoiceNotesListView` — reached from a subtle "future-you." link below the home stones (`quellWhisper` `quellCaption`). Each row: date, "play" / "stop" toggle, "delete". "record new" stone shows when `canAddMore`.
- [x] Local-only. UserDefaults + Documents/. No cloud sync.
- [x] Re-record: deferred. v1 is delete-then-record-new (the "redo" affordance during recording covers in-session redo).

---

## Phase 8: Pattern Detective (Basic)

### Slice 8.1: Quiet logging

- [ ] Capture trigger tags, time of day, day of week, tool used, wave check outcome
- [ ] Local Core Data or SwiftData store

### Slice 8.2: Weekly soft summary

- [ ] Once a week, a gentle reflection: "your urges clustered Mon/Tue evenings this week"
- [ ] Never punitive. Never numerical bragging or shaming.
- [ ] Opt-out available

---

## Phase 9: Boring Meeting Protocol

### Slice 9.1: Discrete in-meeting mode

- [x] One-tap entry via subtle "in a meeting." link below the home stones (alongside "future-you.").
- [x] `BoringMeetingView` on `quellMidnight` — looks like a plain notes document with three sections.
- [x] Hand fidget prompts (5 text instructions, scrollable).
- [x] Silent isometric desk exercises (5 text instructions).
- [x] Silent breath: 3 text prompts ("in for 4. hold for 4. out for 6." / "no one will know." / "again."). Haptic-only animated breath cycle deferred — would require a long-running Timer + UIImpactFeedbackGenerator pulse loop. Text-only is sufficient for v1.

### Slice 9.2: Quick exit

- [x] Small "done" button top-right, in `quellLabel` `quellWhisper`. Tap-anywhere conflicts with scroll content; "done" is the pragmatic compromise. Still no friction — tiny, always reachable.

---

## Phase 10: Anti-streak Heat Map + Settings + Crisis Resources

### Slice 10.1: Engagement heat map

- [ ] Calendar-style visualization of urge-flow engagement
- [ ] Visual celebrates showing up, never punishes gaps
- [ ] No numbers, no streaks

### Slice 10.2: Settings

- [ ] Wren tone preference
- [ ] Notification preferences
- [ ] Stealth mode toggles
- [ ] Audio on/off
- [ ] Haptic on/off

### Slice 10.3: Crisis resources

- [ ] Always accessible within 2 taps from any screen
- [ ] NAED helpline, 988, and clear "this app is a supplement to professional care" copy
- [ ] No shame language

### Slice 10.4: About + safety

- [ ] About page with philosophy summary
- [ ] Clinical advisor credit (when secured)
- [ ] Privacy promise: local-only data

---

## Phase 11: Stealth Features

### Slice 11.1: Quick-blur

- [x] Shake phone → `DisguiseView` fades over everything from the `RootView` level. Detected via `ShakeDetector` (UIViewControllerRepresentable that overrides `motionEnded` and posts `Notification.Name.deviceShaken`).
- [x] DisguiseView: white background, Apple-Notes-style "Notes" header in 34pt bold + 6 fake row entries (groceries / ideas / to-do / weekend plans / wifi password / birthday list) with system fonts and timestamp captions. Looks like nothing in the Quell brand.
- [x] Return on tap anywhere.
- [ ] Double-tap back as alternative trigger — not shipped. Less standard gesture, harder to implement reliably; shake is the iOS-native disguise gesture.

### Slice 11.2: Disguise mode

- [ ] Optional setting: app appearance changes to look like a generic breathing or notes tool
- [ ] Long-press a specific element to reveal full Quell

### Slice 11.3: Notification copy system

- [ ] All notifications use Wren's voice, never diagnostic language
- [ ] Lock screen previews always neutral
- [ ] Audio routes through earbuds only by default

---

## Phase 12: Polish + TestFlight

### Slice 12.1: Onboarding

- [x] First-launch flow gated by `@AppStorage("quell.hasOnboarded")`. `OnboardingView` shows 6 tap-to-advance lines in `quellDisplay` on `quellMidnight`: "hi." / "i'm wren." / "i'm here when the urge is loud, when the wave is rising, when you need a minute." / "no fixing. just presence." / "if it gets too big, 988 is always one tap away." / "ready when you are." Each fades out then in via `quellEaseSlow` (700ms gap). Last tap completes and dissolves into the home.
- [x] Crisis resources mentioned naturally (the "988" line is embedded in the introduction, not as a separate screen).
- [ ] Optional opt-ins for notifications, haptics, audio — deferred to Phase 10.2 Settings. Notifications already prompt at moment of need (JustEat). Haptic/audio tone preferences belong in Settings.

### Slice 12.2: App icon

- [ ] Final icon design (single soft wave or glowing circle, dark background)
- [ ] All required sizes generated

### Slice 12.3: TestFlight prep

- [ ] App Store Connect setup
- [ ] Build, archive, upload
- [ ] Internal testers (Bailey + 2-3 trusted)
- [ ] External testers (5-10 target users via outreach)

### Slice 12.4: Beta feedback loop

- [ ] In-app feedback mechanism (or Discord/email)
- [ ] Triage feedback into bugs / philosophy violations / nice-to-haves
- [ ] Fix bugs and philosophy violations only — defer nice-to-haves

---

## Phase 13: App Store Submission

### Slice 13.1: Listing copy

- [ ] App Store name + subtitle
- [ ] Full description
- [ ] Keywords
- [ ] Privacy policy + terms (real ones, not boilerplate — local data, no tracking)
- [ ] Age rating questionnaire

### Slice 13.2: Screenshots + preview

- [ ] 5-7 screenshots showcasing key flows without violating ED safety guidelines
- [ ] Optional 30-second app preview video
- [ ] Frame everything in the brand visual world

### Slice 13.3: Clinical advisor on the masthead

- [ ] Confirm advisor credit on App Store listing and About page
- [ ] Have safety architecture statement ready for App Review

### Slice 13.4: Submit

- [ ] Submit for review
- [ ] Be ready to respond to reviewer questions about ED content
- [ ] Have a plan if rejected (most ED-adjacent apps go through 2+ rounds)

---

## Backlog (post-launch)

Things we deliberately deferred. Revisit only after launch.

- Audio companion (Wren as voice, not just text)
- Calendar-aware Pre-mortem
- Voice-first urge support
- Hunger calibration practice exercises
- Movement library (30+ short videos)
- Permission Pantry (structured exposure protocol)
- Co-pilot mode (full version)
- Personalization engine (which tools work for which states)
- Optional therapist integration
- Android version
- iPad-optimized layouts
- Apple Watch companion (only if it can be done without violating ED safety)
- Home-screen widget — surface a small breathing orb (slow pulse) or a single rotating Wren line as a daily presence on the iOS home screen. Tap routes straight into "In it" co-regulation. Fits the "always-accessible during urge moments" goal: moves support to the surface where the user's eye already lives. Requires a WidgetKit extension target and possibly an App Group for shared state.

---

*This file is the live checklist. Update statuses as we go. Add slices when scope clarifies. Remove or descope when we find ourselves dragging.*
