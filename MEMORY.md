# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 2: Urge Flow**

Slice 2.1 (60-second co-regulation screen) shipped — "In it" now routes to the real flow, not a placeholder. Phase 1 closeout's vibes check and Phase 2 entry decision were skipped explicitly: Bailey jumped from Slice 1.4 approval directly into Slice 2.1. Working forward through 2.2 (Wren's first voice), 2.3 (Fork), 2.4 (Mood / Anxious protocol), 2.5 (Wave Check), 2.6 (Debrief).

## Last Session Summary

Big atmospheric and feature push, in response to Bailey's feel feedback ("the app feels basic and boring" and "there aren't enough features for it to feel useful").

**New preventive features.** `BeforeFoodView` reachable from a fourth `before food.` link on home, with two paths: `HungerCheckView` (4 tap-to-advance Wren prompts about interoception, then commit "hungry" → BodyRoute / "something else" → CoRegulation) and a pre-meal grounding moment (BreathingMomentView with `WrenVoice.preMeal` phrases). `SteadyView` replaces the bare closing-line for the Steady stone — adds an optional "leave a note for future-you" path that routes to voice record. Sensory swap entries expanded from 20 → ~35.

**Atmosphere layers.** Two ethereal `JellyfishField` jellyfish in opposite corners (cool moon upper-right, warm glow lower-left) drifting in slow elliptical orbits around the screen perimeter (~6-8 min full lap), with slow current perturbation + small wobble + bell pulse + halo via single radial gradient (5 stops, no banding). Tentacles are curving Bezier ribbons with compound-wave undulation, per-tentacle parameter variation, and dynamic bias (always flow inward toward center, regardless of jelly's current position). Twinkling sparkle stars near each. `BioluminescentField` particles now drift continuously across the screen with edge-wrap (velocityX ±0.012, velocityY ±0.008 screens/sec), instead of just oscillating in place. Both effects layered behind content on every brand-emotional screen.

**Accessibility polish (earlier in session).** `SoftSlider` now has `accessibilityAdjustableAction`, label, value, hint. `OnboardingView` tap-to-continue hint. `VoiceNotesListView` rows include date in play/delete labels. Settings chevrons hidden from VoiceOver.

**Op note: perl pass mishap.** A `-i` perl invocation with the script's own shebang truncated 22 screen files mid-session. Recovered via `git checkout`. Lesson: when batch-editing in place, use `perl -i -pe '...'` with the inline expression form, not a separate script file with a shebang. Re-applied JellyfishField insertion via the safer `-pe` approach.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Open: pick next direction.** App is feature-complete and the iterated voice content is now centralized. Remaining code-side: polish/flow validation (walk every screen with fresh eyes, fix rough edges, accessibility / VoiceOver labels). Outside-of-code: NEDA verified number, clinical advisor credit, app icon design, Apple Developer enrollment + TestFlight, App Store listing + privacy policy + screenshots.

## Where We Left Off

Repo state:
- `Quell/Quell/Components/` contains `BreathingShape.swift` and `WordStone.swift`
- `Quell/Quell/Screens/` contains `PlaceholderHomeView.swift`, `StoneDestinationView.swift`, and `CoRegulationView.swift`
- New color token `.quellAbyss` in `QuellColors.swift`
- Routing in `PlaceholderHomeView` uses a typed `Destination` enum
- `CoRegulationView` shows one static prompt; Slice 2.2 will replace it with a rotating phrase system

Next concrete action: Slice 2.2 — design `WrenLine.swift` and a small phrase set. The component needs to handle slow cross-fades between phrases. Likely a Timer or breath-cycle-aware rotation. Phrases probably rotate every breath cycle (~11.6s) or every 2-3 cycles. Need to draft 5-7 co-regulation phrases in Wren's voice — warm, present, never clinical.

## Open Questions

Things we have not decided yet but will need to soon. Each has a "decide by" phase.

- **App icon design.** Decide by Phase 12. Direction: a single soft wave curve or glowing circle on dark background. Abstract. Inconspicuous.
- **Bundle identifier.** Decide at Phase 0 setup. Suggested: `com.lightspacelabs.quell`
- **App Store name reservation.** Decide before Phase 12. Confirm Quell is available in App Store Connect (requires Apple Developer account).
- **Clinical advisor.** Decide by Phase 12. Outreach can begin earlier; ideally have someone signed before TestFlight.
- **Pricing model.** Decide by Phase 12. Options: free with optional one-time unlock, freemium with subscription, fully free. Lean toward free in beta, decide before App Store launch.

## What's Working

(Update as we go.)

- Color palette derived from a real reference image rather than guessed. Roles and rules are explicit, so future decisions about where to use color have a clear framework.
- Design system token files (colors, typography, spacing, motion) are in place. All call sites can reference `.quellMidnight`, `.quellBody`, `.quellSpace4`, `.quellEaseGentle()` etc. without hard-coded values.
- Fraunces and Geist render correctly on iOS Simulator. Variable fonts, family-name-only, weight applied via `.weight(...)`.
- `TokenPreview` is the current visual checkpoint and shows the full palette/type/spacing/motion language in one screen.
- `PlaceholderHomeView` ships as the app's actual root: "quell" in Fraunces Light, centered on `quellMidnight`. Brand presence on first launch. *(As of Slice 1.1, the wordmark is replaced by `BreathingShape`; the view name is retained as the evolving home surface.)*
- `BreathingShape` reads as a real breath. Peak hold + trough rest beat the metronomic feel; the breath-modulated blur (slightly more diffuse at peak) gives it body warmth; ember core through dawn to moon makes the orb look like light through a closed eyelid. Visual checkpoint passed on first stare-test after iteration.
- "right now i'm…" prompt at `quellTitle` (24pt) reads as a gentle invitation. The lowercase + horizontal ellipsis carries the brand voice (matches "i'm here. breathe with me." in Slice 2.1's spec). 36pt was too forward; 24pt is the sweet spot for a question that invites rather than demands.
- Word-stones feel like words, not buttons. Fraunces light at 20pt with no chrome reads as language; the soft-impact haptic + glow on tap acknowledges without snapping. Bailey's gut check on the visual checkpoint: "looks good."
- The home → destination → home dissolve reads as water. Cross-fade with no back-stacking, no slide, no chrome — just the surface dissolving from a question to a held word and back. Bailey's checkpoint: "good."
- The co-regulation field reads as a deeper interior than the home. The `quellAbyss` background is barely darker than `quellMidnight` numerically, but combined with the larger orb, the held silence, and Wren's rotating phrases, it lands as descent — like dimming the lights to be present with someone. Bailey's checkpoint: "good."
- Wren's voice is friend-on-the-floor, not calm-presenter. First draft of co-regulation phrases used therapy-stock affirmations ("i see you", "your body is doing the work") and read cheesy. Rewrote to observational/plainspoken: `yeah, this is hard.` / `no rush.` / `it'll pass. it always does.` Less self-announcing, fewer "i" frames, no instruction.
- The Fork reads as a real choice with three labeled shapes in a triangle, not as overwhelming. Single-tap commits with a soft haptic + brief glow give tactile confirmation without making the user "discover" what each shape means. Bailey's checkpoint: "good, lets move on."
- The Wave Check slider is the literal wave. Two stroked sine-wave layers (`quellMoon` primary + softer `quellGlow` at phase offset) whose amplitude responds live to the user's drag. Dragging toward "smaller" calms the wave; toward "bigger" amplifies it. The metaphor is the answer — the user reports the wave's state by *being* the wave's state. Bailey's checkpoint: "looks good."
- Eat Anyway is wired end-to-end via Body → entry → mindful or just-eat → "still here." close. Notifications for the just-eat 20-min ping work via UNUserNotificationCenter; permission requested only at the moment of need. Bailey's signature feature is real.
- Voice notes are recordable and play back inline during co-regulation. Max 5, local-only, mic permission requested at moment of need. The deepest emotional hook in the brief is now real — your sober self can record a note for your future-overwhelmed self.
- All six moods (Anxious / Lonely / Tired / Bored / Numb / Rage) lead to real protocols now via a generic `MoodProtocolView`. Don't-know on the Fork goes through a 6-area body scan that routes intelligently to Eat Anyway or co-regulation. The urge flow has no placeholder leaves left.
- Body route is the spec'd sensory icon picker, not an Eat Anyway shortcut. ~20 swaps across crunch / cold / warm / sweet / salty are real concrete suggestions with "why it works" copy. Easy to extend: add to `SensorySwapStore.seedSwaps()`.
- First impression and stealth are real. Onboarding introduces Wren in 6 soft lines on first launch. Quick-blur disguises the app as a fake Notes screen on shake from any screen. Two of the brand's most distinctive surfaces are live.
- Home is complete for all four states — Steady acknowledges and closes, Wobbling and Need Company route to soft breathing moments, In It runs the full urge flow. Plus stealth utility "in a meeting." reachable from anywhere via a subtle home link.
- App is ship-ready in scope: settings, crisis resources, about page, onboarding, stealth all live. Remaining holes are content-side (NEDA verified number, clinical advisor credit, app icon design) and a real TestFlight build, not code.
- Patterns/heat map is live. Local-only logs at terminal hooks; calendar grid in `PatternsView` lights up days the user engaged. The data doesn't punish gaps — it celebrates showing up.
- App is now both reactive and proactive. `before food.` adds preventive practice (hunger check + pre-meal grounding) outside urge moments; Steady leads to optional voice notes; sensory swaps doubled.
- Atmosphere is alive. Two slow-drifting bioluminescent jellyfish trace the screen perimeter; bioluminescent particles drift in their own currents and wrap around edges. The field reads as ocean.

## What's Not Working

(Update as we go.)

- The fade-in on `PlaceholderHomeView` is technically running but visually imperceptible — iOS's launch transition masks it. Not a bug; pattern needs to live somewhere without a launch boundary to read properly. Revisit when applied to in-app transitions.

## Vibes Check

How does the app feel right now? This is the "look at it on the phone" gut check.

Not on the phone yet. First gut check happens at end of Phase 0.

## Recent Decisions

Most recent first. Move to the brief's Decisions Log when stable.

**Slice 3.1 (WrenVoice centralization):**

- **`DesignSystem/WrenVoice.swift` is the single source of truth for Wren's iterated voice content.** When tuning phrases (cheesy → friend-on-the-floor type revisions), edit there; views just read. Voice principle is documented at the top of the file as a comment.
- **Categorization by context, not by tone.** Sections are "Co-regulation," "Mood protocols," "Eat Anyway," "Wave Check," "Closing lines," etc. — each maps to where the user encounters the phrases.
- **Mood protocol phrase resolution via `WrenVoice.phrases(for: MoodChoice)`** — single function, exhaustive switch. Pattern reusable for any future "content varies by enum case" need.
- **Skipped centralizing single-word UI prompts and section titles.** They're not iterated; centralizing them adds plumbing without payoff. WrenVoice holds the things Bailey actually edits.

**Phase 8 + 10.1 (Patterns / heat map):**

- **`LogStore` follows the same pattern as `VoiceNoteStore`**: `@MainActor final class ObservableObject` + `static let shared` + UserDefaults JSON. Use this template for any future local-only data layer.
- **Logging at terminal hooks, not transitions.** Three hooks cover the meaningful sessions: Wave Check (urge resolved), ClosingLineView (any flow that ends with a closing line), BreathingMomentView (Wobbling/Need-Company). Don't sprinkle log calls everywhere — terminal points only, otherwise the data gets noisy.
- **Calendar grid uses `LogStore.calendarGrid(weeks:)`** which returns `[[Date]]` rows of day-starts. Convert today + N days to a 7-wide week-major layout with `Calendar.startOfDay(for:)`.
- **Reflection scales with engagement count, never numerical.** "you've been here a lot this week." beats "5 sessions this week." If summary copy ever needs to expose a number, that's a brand violation — find a phrasing that doesn't.

**Phase 10.2 + 10.3 + 10.4 (Settings, Crisis, About):**

- **Settings is the new utility surface.** Anything that was deferred for "v2 toggles" or "system permission link" lands here. Pattern: section groups with `quellShade` capsule backgrounds, `quellCaption` `quellWhisper` headers, body rows in `quellBody`. Reusable for any future "list of toggleable / linkable items" screen.
- **`@AppStorage` is the toggle persistence layer.** `quell.hapticEnabled`, `quell.audioEnabled`, `quell.hasOnboarded`. Toggles in views that read these AppStorage values respond live.
- **Wiring a toggle requires a real consumer.** Haptic toggle works because `WordStone` reads `quell.hapticEnabled` and guards `tapCount` increments. Audio toggle is persisted but unwired — voice notes are user-triggered with no clean "audio off" semantic. When adding new toggles, name the consumer up front; persisting without wiring is debt.
- **`CrisisResourcesView` consolidates Wave-Check escalation and Settings-side crisis access.** Two callsites for one view. Pattern: build screens that don't bind to a specific entry point, route them by `Destination` enum from anywhere.
- **`AboutView` has the privacy promise codified in copy.** "everything you save stays on your device. no cloud sync. no tracking. no analytics." If we ever introduce optional cloud sync or analytics, this copy must change first.
- **`UIKit` import for `UIApplication.openSettingsURLString`** — the iOS Settings deep link constant lives in UIKit even when imported into a SwiftUI file.

**Home stones + Phase 9 (Boring Meeting):**

- **`BreathingMomentView` is the generic "soft breath moment" component.** Distinct from `CoRegulationView` (heavier, urge-flow framing, 8s held silence, "skip ahead" to Fork) — `BreathingMomentView` is a 240pt orb + Wren phrases + "okay" close on `quellMidnight`. Use this for any future "presence moment" that doesn't need the full urge flow. Optional `extra` stone parameter for screen-specific actions.
- **Tonal world hierarchy is now three-tier**: `quellMidnight` (home + light moments) / `quellAbyss` (urge-flow interior) / pure white (`DisguiseView` only). When introducing future surfaces, place them by emotional weight in this hierarchy.
- **Tap-anywhere-to-dismiss conflicts with ScrollView content.** `BoringMeetingView` uses a tiny "done" button instead. Pattern: when content needs to scroll, give a small explicit dismiss; reserve tap-anywhere for non-scrolling presence screens.
- **`sms:` URL via `@Environment(\.openURL)`** opens iOS Messages with no recipient. User picks contact themselves. Same pattern as `tel:988` in `CoPilotPlaceholderView`. Both work without contacts permission.

**Onboarding + Quick-blur (12.1 + 11.1):**

- **`RootView` is the new app root.** It owns the onboarding gate, the disguise overlay, and the global shake listener. New global features should go here, not on individual screens. `QuellApp` is now just `WindowGroup { RootView() }`.
- **`@AppStorage` is the lightweight persistence pattern** for one-off boolean flags like `hasOnboarded`. Use UserDefaults JSON encoding (like `VoiceNoteStore`) for structured data; `@AppStorage` for simple flags and toggles.
- **`ShakeDetector` UIViewControllerRepresentable** is the SwiftUI-native way to capture device shake. SwiftUI doesn't have native shake detection; the responder chain via UIViewController + NotificationCenter is the cleanest bridge. Pattern reusable for any iOS responder-chain event SwiftUI doesn't surface natively.
- **DisguiseView is intentionally non-Quell-branded.** White background, system fonts, Apple-Notes-style content. The point is "this looks like nothing." If we ever want a Quell-branded "calm" mode that's not a stealth disguise, that's a different feature.

**Phase 4 (Body route + Sensory Swaps):**

- **Combined browse + detail in one view via internal state**, not two routing cases. `SensorySwapsView` toggles between list and detail using `selected: SensorySwap?` + `.transition(.opacity)`. Single `.sensorySwaps(SensoryCategory)` destination. Pattern reusable for any "list-then-detail" sub-flow that doesn't need cross-deep-linking.
- **Content seeded inline in Swift, not bundled JSON.** ~20 swaps lives fine in a static func; bundled JSON adds build-step complexity for marginal benefit at this size. Migrate to JSON if the seed grows past ~100 entries or if non-developers need to edit it.
- **Texture squares use `LinearGradient` with category-specific token palettes** (e.g. crunch = ember→midnight). No food images — the gradient suggests sensation, not the food. If a category needs more visual punch, layer two gradients or add a Canvas-drawn pattern; for v1 plain gradients read fine.
- **`SensoryCategory` token-color mapping** in an extension (`gradientColors: [Color]`). Keeps tokens out of view files. Same pattern would work for a future "destination color" mapping if other Phase 6 protocols want their own ambient tints.

**Phase 6 (Mood protocols + Don't Know scan):**

- **Generic `MoodProtocolView(mood:)` with mood-specific phrase sets + durations.** All six moods share one component instead of six. Mood-specific config lives in computed properties (`phrases` and `duration`) inside the view. Pattern reusable for other "same shape, different content per case" screens.
- **`Destination.moodProtocol(MoodChoice)`** with associated value works fine for `Equatable` since `MoodChoice` is Equatable. Replaced separate `.anxiousProtocol` case with this generic one.
- **Don't-know body scan suggestion logic is intentionally simple.** `most-tight == stomach → eat-anyway, else → co-regulation`. Crude but correct for v1. When Phase 8 lands the Pattern Detective with logged outcomes, scan suggestions could become smarter (which-suggestion-leads-to-smaller-wave-checks-most-often), but that's well-future.
- **Wren phrase principle held across all 5 new phrase sets.** Friend-on-the-floor, no therapy-stock, no self-announcing "i" frames, observational over declarative. See per-mood arrays in `MoodProtocolView.phrases`. Worth re-reading when adding more Wren copy elsewhere.

**Phase 7 (Future Self Voice Notes):**

- **`@StateObject` on `ObservableObject` requires `import Combine` explicitly** in iOS 17 — SwiftUI doesn't transitively re-export it. Build fails with "type does not conform to ObservableObject" + cryptic Combine subscript errors. Add the import.
- **Permission requests at the moment of need, not at app launch.** Mic permission is requested when the user taps "record" inside `RecordVoiceNoteView` (same pattern as the JustEat notification permission in Phase 5). Denial routes to a soft "microphone access is off, you can turn it on in settings." screen with an "ok" stone. Pattern reusable for any future permission (camera, location, etc.).
- **`Storage/` folder is the new home for any data layer code.** Currently `VoiceNoteStore.swift`. When Phase 8 (Pattern Detective) needs storage, add files here. Each store is a `@MainActor final class ObservableObject` with a `static let shared` and UserDefaults-backed save/load.
- **Audio session categories matter.** `RecordVoiceNoteView` uses `.playAndRecord` with `.defaultToSpeaker` (so playback is loud, not earpiece). `VoiceNotesListView` and `CoRegulationView` use `.playback` (no recording). When adding more audio surfaces, set the right category before playing/recording.
- **Inline playback in `CoRegulationView` deliberately doesn't pause the breath/Wren.** The user hears their voice while the orb keeps animating and phrases keep rotating. Continuity matters in co-regulation; an audio-only modal would have broken it.

**Slice 2.6 + Phase 5 (Debrief redesign + Eat Anyway):**

- **Spec deviations honored both ways.** 2.6 spec called for three prompts; Bailey: "i don't want to answer questions." 5.3 also called for a post-eat debrief; same answer. Both shipped as a single `ClosingLineView` parameterized by a line — no save, no questions. Pattern: when a slice spec adds friction the brief's spirit doesn't require, drop it and amend.
- **`ClosingLineView` is the reusable closer.** Parameterized `line: String`, 3.5s display, fade in via `quellEaseSlow`, then `onComplete`. Two callsites so far: `"thanks for showing up."` (Wave Check smaller) and `"still here."` (Eat Anyway). Likely a third callsite for other "okay, that happened" moments going forward.
- **Local notifications via `UNUserNotificationCenter`.** First use in `JustEatView` (20-min check-in). Permission requested at the moment of need (user starts JustEat), not at app launch. Denial is silent. Pattern is reusable for other timed pings; should consolidate into a `Notifications/` helper if a second screen needs one.
- **Routing enum has 11 cases now** (`.stone`, `.coRegulation`, `.fork`, `.mood`, `.anxiousProtocol`, `.waveCheck`, `.coPilot`, `.eatAnywayEntry`, `.eatMindful`, `.eatJust`, `.closingLine(String)`). Note `.closingLine` carries an associated value — works with Equatable since String is Equatable. Refactor to a router type when the enum hits ~15 cases or when sub-flows want their own state.
- **Plan order isn't strict.** Jumped from Phase 2.6 directly to Phase 5, skipping Phase 3 (Wren character) and Phase 4 (Body route + Sensory Swaps). The brief permits this — when a high-value chunk is reachable and self-contained, build it. Phase 3.2 (Wren's presence) and Phase 4 still need to land before the long-press-on-Wren Eat Anyway access point can be wired.

**Phase 2 — Slices 2.4 + 2.5 (Mood / Anxious protocol / Wave Check / Co-pilot):**

- **`SoftSlider` ships the wave metaphor literally.** Three iterations to land it: iOS default `Slider` (too utilitarian) → custom flat-track + orb thumb (cleaner but didn't sell the metaphor) → wave-as-track with amplitude responding live to slider value (the answer is the visual). Worth knowing for future "feels like a feeling, not a survey" moments: the metaphor itself can be the interaction, not just decoration around it.
- **`WrenLine` reused for the Anxious protocol with a slower interval (30s).** Established pattern: phrase rotation interval scales with the screen's emotional register — co-regulation is 22s (~2 breath cycles), the protocol is 30s (more reflective space). Future protocol screens (Phase 6.1–6.5 Lonely/Tired/Bored/Numb/Rage, Phase 5 eat anyway) should pick intervals based on what the user is being asked to do, not a fixed default.
- **Protocol auto-advance via `Task` + `Task.sleep`.** `AnxiousProtocolView` runs `Task { try? await Task.sleep(for: duration); onAdvance() }` for the 2-min auto-route to Wave Check. The duration is parameterizable so dev testing can use shorter values. Pattern reusable for any time-bounded protocol screen.
- **`Destination` enum is now 7 cases** (`.stone`, `.coRegulation`, `.fork`, `.mood`, `.anxiousProtocol`, `.waveCheck`, `.coPilot`). Slice 2.6 adds `.debrief`. Phase 6 will add 5 more mood-protocol cases. By the time we hit ~12 cases (likely Slice 6.5), refactor to a router type or `NavigationStack` with a custom transition. Flat enum still readable for now.
- **Crisis resource numbers must be verified before shipping.** Excluded NAED helpline from `CoPilotPlaceholderView` v1 because I didn't have a verified number. 988 is the Suicide & Crisis Lifeline and is well-known. Phase 10.3 owns proper crisis resources and should pull verified numbers from clinical advisor input before TestFlight.
- **Home-screen widget jotted into backlog.** Bailey raised it organically: small breathing orb or single rotating Wren line as a daily home-screen presence with tap-to-"In it." Fits the "always-accessible during urge moments" goal. Requires a WidgetKit extension target.

**Phase 2 — Slice 2.3 (The Fork):**

- **Shipped single-tap commits with labels visible**, not the spec'd two-tap discovery. The spec asked for "tap reveals label, second tap commits" with a stare-test guidance to "test with no labels first." That guidance was about answering a layout question (does the bare triangle read as a choice?), not about prescribing the production interaction. In stare-test the two-tap discovery felt like friction during an urge moment. Single-tap is the brand-correct default for feel-driven surfaces (see also: `feedback_minimum_friction.md`).
- **`Destination` enum is the flat router for the urge flow.** Now: `.stone(String)`, `.coRegulation`, `.fork`. As Phase 2-6 destinations land, the enum will grow. By the time it's unwieldy (likely Phase 5+), refactor to a NavigationStack or a router type. For now, flat is fine.
- **`CoRegulationView.onExit` renamed to `onAdvance`.** Semantic shift: "skip ahead" no longer dismisses to home, it advances to the Fork. The pattern for protocol-screen callbacks going forward: `onAdvance` for forward motion, `onDismiss` for backward/return. Use these names consistently.
- **Triangle layout via `.offset` in a ZStack.** Three shapes positioned at (0, -120), (-90, 80), (90, 80). Phone is taller than wide, so vertical offsets are larger than horizontal. Reusable pattern for future "small fixed set of options" layouts where a Grid would feel too rigid.

**Phase 2 — Slice 2.2 (Wren's first voice):**

- **Wren is friend-on-the-floor, not calm-presenter.** The first draft of co-regulation phrases used therapy-stock affirmations ("i see you", "you're not alone in this", "your body is doing the work") and Bailey called them cheesy. The voice principle that emerged: observational over declarative, plainspoken over poetic, fewer self-announcing "i" frames, no instruction. Use as a guide for all future Wren writing (Phase 2.4 anxious protocol, Phase 5 eat anyway, etc.).
- **Phrase rotation cadence: 22s ≈ 2 breath cycles.** Each phrase has time to land before transitioning. Fade is `quellDurSlow` (0.8s) — the existing slow tier — and reads as "slow enough" so far. If a future protocol screen wants slower phrase fades, consider adding a `quellDurSlow2` or similar.
- **`WrenLine` owns its own rotation.** Component takes a `phrases: [String]` and an `interval: Duration`, runs a `while !Task.isCancelled` loop in `.task`. Reusable for any Wren-voiced screen. When CoRegulationView is dismissed, the task is cancelled cleanly.
- **First phrase is deterministic** (always "still here." for co-reg). The user gets a consistent landing each time they enter the urge flow.

**Phase 2 — Slice 2.1 (Co-regulation screen):**

- **`quellAbyss` color token added** (#040714). Deeper than `quellMidnight` — the held interior of the urge flow. Future use cases: other deep-flow surfaces in Phases 2-6 protocols. The numerical difference from `quellMidnight` is small but the tonal cue lands as "going deeper."
- **Routing refactored to a typed `Destination` enum** (`.stone(String)` for placeholders, `.coRegulation` for the new view). String-based routing was fine for Slice 1.4's single placeholder type but doesn't scale to Phase 2-6 destinations. Switch is in `PlaceholderHomeView`.
- **Co-regulation cadence: 1.0s prompt → 1.6s orb → 8.0s held silence → actions.** The 8 seconds is the spec's bar; the cadence inside it stages the field, the voice, then the breath. Long enough to drop in, short enough not to punish. Bailey passed it on the visual checkpoint.
- **"stay" re-appearance pattern.** "stay" hides the actions and re-surfaces them after 12s via `Task { @MainActor in ... }`. The user can sit indefinitely without being stuck, since this view has no other exit gesture. If the pattern recurs (other protocol screens with held silences), worth extracting.
- **Two-line forced break for "i'm here. / breathe with me."** Used `\n` rather than letting it wrap. The deliberate break gives Wren two beats — the arrival, then the invitation. Worth knowing for other Wren voice work.
- **`WordStone` `.fixedSize(horizontal: true, vertical: false)` patch.** Prevents truncation when used in HStack contexts. Was originally fine in the LazyVGrid because cells gave it room; failed in the HStack here. The fix is robust — applies in every context.

**Phase 1 — Slice 1.4 (Placeholder routing):**

- **State-driven swap over `NavigationStack`.** Routing uses a single `@State var selected: String?` to toggle between home and destination. Reason: `NavigationStack`'s default push is a slide, and customizing it for a soft dissolve fights the framework. The dissolve is the brand. When Phase 2 introduces real depth, we'll likely add `NavigationStack` with a custom transition theme, or build a router around state + transitions. For Phase 1's two-screen depth, state is enough.
- **Home stays alive in the background.** Both home and destination are children of a single ZStack; home is opacity-toggled rather than swapped. This means the home's staggered fade-in cadence only plays on first launch, and return-from-destination is an opacity flip rather than a re-stage. The breathing orb keeps animating in the background even when invisible — slight battery cost we'll evaluate later if it matters.
- **Tap-anywhere dismiss.** No chrome, no back chevron, no swipe gesture. The destination is a held surface; touching it dissolves it back. Discoverability could be a concern for real destinations, but for placeholders it's fine — and it's the most water-like default. Revisit when destinations have content.
- **Held-space moment before the word arrives.** Destination word fades in 0.2s after the surface materializes. This creates a brief "you've arrived" pause — the field receives you, and then the word is there. Reused pattern: stagger micro-delays between elements arriving on a screen, even within a single view.

**Phase 1 — Slices 1.2 + 1.3 (Prompt and word-stones):**

- **Prompt typography.** "right now i'm…" uses `.quellTitle` (Fraunces 24pt light), not `.quellDisplay` (36pt) as the slice spec originally called for. 36pt felt too forward for a prompt-as-invitation; 24pt holds presence without demanding.
- **`.quellStone` token added** to `QuellTypography.swift`. Fraunces 20pt light, between `quellTitle` and `quellHeadline`. Anticipated reuse: mood bubbles (Slice 2.4), sensory icons (Slice 4.1), and other "soft option label" patterns. Display-voice (Fraunces) was chosen over UI-voice (Geist) so word-stones read as language rather than interface — they're choices the user is making in their own voice, not buttons in a chrome.
- **Word-stone tap response.** Three-layer feedback: scale-down to 0.96 during press (live, via custom `StonePressStyle`), soft-impact haptic (`.sensoryFeedback(.impact(flexibility: .soft, intensity: 0.6))`), and a `quellGlow` capsule + shadow that fades over `quellDurSlow`. The haptic + glow fire on tap action; the scale fires on press. This means the user feels the press start and release as separate moments — gentle, not punchy.
- **Layout: `LazyVGrid` over paired HStacks.** Two flexible columns + `quellSpace7` horizontal padding so labels of varying widths column-align cleanly. HStack-pair rows centered each pair independently, which made the second row drift off the first row's column lines.
- **Staggered fade-in cadence.** Orb t=0, prompt t=0.6, stones t=1.2 — each over `quellDurSlow` (0.8s). Home arrives in layers, like a doorway opening.

**Phase 1 — Slice 1.1 (Breathing shape):**

- **Breath orb gradient.** Four-stop radial: ember (0.0) → dawn (0.22) → moon (0.5) → midnight (1.0). Dawn bridges the warm-to-cool perceptual jump. Notable: ember (brief tier "charged/rare warmth") now appears as a persistent always-on element. Reads as body-warmth at the breath's heart, not as alert/charged. **Flag if ember appears in another always-on context** — that would be a real conflict with the brief's stated rule. Here it earned its place; elsewhere it should still be charged/rare.
- **Breath cycle pacing.** 4s inhale + 0.4s peak hold + 6s exhale + 1.2s trough rest, both directions easing on `quellEaseGentle`. The hold/rest pauses are what unlock the alive feel; without them the cycle reads as a metronome. The longer trough rest is the parasympathetic moment.
- **Breath-modulated blur.** `.blur(radius: 6)` placed before `.scaleEffect` so the blur scales with the orb. Slightly more diffuse at peak, more defined at trough. Subtle but adds depth and softens the warm-cool gradient transition.
- **Original Slice 1.1 spec deviated from twice in iteration.** Spec said `quellMoon` center → `quellMidnight` edge with `quellEaseSlow`. Actual is the ember-led four-stop gradient with `quellEaseGentle`. Both deviations were arrived at through stare-test feedback. TASKS.md has been amended to reflect what shipped.

_(Phase 0 decisions migrated to the brief's Decisions Log: typography, bundle ID, iOS 17.0 minimum, bioluminescent visual concept + palette rebuild, iPhone-only destinations.)_

Operational notes from Phase 0 worth keeping locally:

- Fraunces and Geist were sourced as variable `.ttf` files from `googlefonts/fraunces` and `vercel/geist-font` (default branch differed: Fraunces is on `master`, Geist is on `main`). Registered via a project `Info.plist` with `UIAppFonts`. SwiftUI calls use family name + `.weight(...)`.
- Project uses Xcode 16's synchronized-folder mechanism (`PBXFileSystemSynchronizedRootGroup`); files dropped into `Quell/Quell/` are auto-included in the target. `Info.plist` is the one explicit exception.

## File Structure (current)

```
Quell/
├── QUELL_PROJECT_BRIEF.md
├── MEMORY.md
├── TASKS.md
├── .gitignore
└── Quell/
    ├── Quell.xcodeproj
    └── Quell/
        ├── QuellApp.swift              (root view: PlaceholderHomeView())
        ├── Info.plist                  (UIAppFonts registration)
        ├── Assets.xcassets/
        ├── DesignSystem/
        │   ├── QuellColors.swift
        │   ├── QuellTypography.swift
        │   ├── QuellSpacing.swift
        │   ├── QuellMotion.swift
        │   ├── TokenPreview.swift
        │   └── WrenVoice.swift
        ├── Components/
        │   ├── BreathingShape.swift
        │   ├── WordStone.swift
        │   ├── WrenLine.swift
        │   ├── SoftSlider.swift
        │   ├── ShakeDetector.swift
        │   ├── BioluminescentField.swift
        │   └── JellyfishField.swift
        ├── Screens/
        │   ├── PlaceholderHomeView.swift
        │   ├── StoneDestinationView.swift
        │   ├── CoRegulationView.swift
        │   ├── ForkView.swift
        │   ├── MoodView.swift
        │   ├── MoodProtocolView.swift
        │   ├── DontKnowScanView.swift
        │   ├── RagePadView.swift
        │   ├── WaveCheckView.swift
        │   ├── ClosingLineView.swift
        │   ├── EatAnywayEntryView.swift
        │   ├── MindfulEatView.swift
        │   ├── JustEatView.swift
        │   ├── RecordVoiceNoteView.swift
        │   ├── VoiceNotesListView.swift
        │   ├── BodyRouteView.swift
        │   ├── SensorySwapsView.swift
        │   ├── OnboardingView.swift
        │   ├── DisguiseView.swift
        │   ├── BreathingMomentView.swift
        │   ├── BoringMeetingView.swift
        │   ├── SettingsView.swift
        │   ├── CrisisResourcesView.swift
        │   ├── AboutView.swift
        │   ├── PatternsView.swift
        │   ├── BeforeFoodView.swift
        │   ├── HungerCheckView.swift
        │   └── SteadyView.swift
        ├── Storage/
        │   ├── VoiceNoteStore.swift
        │   ├── SensorySwapStore.swift
        │   └── LogStore.swift
        └── Fonts/
            ├── Fraunces.ttf
            └── Geist.ttf
```

Will expand as we build out screens.

## Notes for Next Session

When you start the next session, do this in order:

1. Read `QUELL_PROJECT_BRIEF.md` (full)
2. Read this file (`MEMORY.md`) — focus on Current Phase, Active Slice, Where We Left Off
3. Read `TASKS.md` — focus on the current phase's tasks
4. Confirm with Bailey what slice we're working on
5. Begin work on that slice, and only that slice
6. At the end of the session, update this file's Last Session Summary, Active Slice, Where We Left Off, What's Working, and Vibes Check

---

*Last updated: project initialization (no work session yet).*
