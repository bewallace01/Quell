# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 2: Urge Flow**

Slice 2.1 (60-second co-regulation screen) shipped — "In it" now routes to the real flow, not a placeholder. Phase 1 closeout's vibes check and Phase 2 entry decision were skipped explicitly: Bailey jumped from Slice 1.4 approval directly into Slice 2.1. Working forward through 2.2 (Wren's first voice), 2.3 (Fork), 2.4 (Mood / Anxious protocol), 2.5 (Wave Check), 2.6 (Debrief).

## Last Session Summary

Closed Slice 2.2. Shipped `WrenLine.swift` in `Components/` — a styled text component that owns its own phrase rotation via `.task`. Renders one phrase at a time in `quellDisplay`, cross-fades to the next every 22 seconds (~2 full breath cycles) using `quellEaseSlow` over `quellDurSlow`. CoRegulationView now passes a phrase list and interval; the static "i'm here.\nbreathe with me." line is gone.

First-draft phrases were therapy-stock affirmations ("i see you", "you're not alone in this", "your body is doing the work") and read as cheesy — Bailey called it. Rewrote toward friend-on-the-floor voice: observational, plainspoken, dropped self-announcing "i" frames. Final set: `still here.` / `yeah, this is hard.` / `no rush.` / `we can wait.` / `it'll pass. it always does.` / `just this.` This is the principle for future Wren writing: less calm-presenter, more real-friend-who's-been-here.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Slice 2.3: The Fork.** Create `ForkView.swift` — three soft shapes in a triangle layout (top: Body, lower left: Mood, lower right: Don't know). Tap reveals label, second tap commits. Each fork option fades in over 400ms (matches `quellDurMid`). Visual checkpoint: does the three-option layout feel like a real choice or overwhelming? Test with no labels first. Also: re-route `CoRegulationView`'s "skip ahead" to land on the Fork instead of dismissing to home, and extend the `Destination` enum with a `.fork` case.

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

## What's Not Working

(Update as we go.)

- The fade-in on `PlaceholderHomeView` is technically running but visually imperceptible — iOS's launch transition masks it. Not a bug; pattern needs to live somewhere without a launch boundary to read properly. Revisit when applied to in-app transitions.

## Vibes Check

How does the app feel right now? This is the "look at it on the phone" gut check.

Not on the phone yet. First gut check happens at end of Phase 0.

## Recent Decisions

Most recent first. Move to the brief's Decisions Log when stable.

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
        │   └── TokenPreview.swift
        ├── Components/
        │   ├── BreathingShape.swift
        │   ├── WordStone.swift
        │   └── WrenLine.swift
        ├── Screens/
        │   ├── PlaceholderHomeView.swift
        │   ├── StoneDestinationView.swift
        │   └── CoRegulationView.swift
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
