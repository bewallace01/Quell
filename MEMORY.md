# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 1: Home Screen**

Slices 1.1 (BreathingShape), 1.2 (prompt), and 1.3 (word-stones) all shipped. Home composition is visually complete; only routing (Slice 1.4) remains before Phase 1 closeout.

## Last Session Summary

Closed Slices 1.2 and 1.3 together. Slice 1.2 added the "right now i'm…" prompt above the orb — initially shipped as `quellDisplay` (Fraunces 36pt light), stepped down to `quellTitle` (24pt) after stare-test, with fade-in delayed 0.6s behind the orb. After that change Bailey flagged that the home felt off-balance, but the bottom-half emptiness was the missing word-stones, not a tuning issue with 1.2 — so we pushed forward.

Slice 1.3 introduced `WordStone.swift` in `Components/`: a soft floating word with no chrome at rest, scale-to-0.96-during-press via a custom `StonePressStyle`, soft-impact haptic via SwiftUI's `.sensoryFeedback`, and a brief `quellGlow` capsule + shadow on tap that fades out over `quellDurSlow`. Added a new typography token `.quellStone` (Fraunces 20pt light, between `quellTitle` and `quellHeadline`) — designed to be reused for mood bubbles in Slice 2.4 and other soft option labels. Initial 2x2 layout used two HStacks but labels of different widths centered differently, so switched to `LazyVGrid` with two flexible columns and `quellSpace7` horizontal padding for clean column alignment. Stones fade in last — the home now stages: orb at t=0, prompt at t=0.6, stones at t=1.2.

Operational note: started running `xcodebuild` after Swift edits this session (after Bailey explicitly caught me telling them to verify what I should have verified myself). SourceKit diagnostics in the editor are unreliable for synchronized-root-group projects — they cascade false errors after any file change. Saved as a feedback memory.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Slice 1.4: Placeholder routing.** Each word-stone navigates to a placeholder screen showing just the word it represents. Soft dissolve transition, not a slide. Small back gesture or button to return to home. Visual checkpoint: navigation feels like water, no sharp edges.

## Where We Left Off

Repo state:
- `Quell/Quell/Components/` contains `BreathingShape.swift` and `WordStone.swift`
- `PlaceholderHomeView` is the full home composition: prompt → orb → 2x2 stone grid (Steady · Wobbling / In it · Need company), staggered fade-in
- New typography token `.quellStone` in `QuellTypography.swift`
- Word-stone tap actions are no-op closures — wired to fire haptic + glow visuals but go nowhere yet (Slice 1.4's job)

Next concrete action: Slice 1.4 — give each `WordStone` a destination. Likely a `NavigationStack` (or simple `@State` driven view swap) with a placeholder destination view that renders just the chosen word in `.quellDisplay`. Use a soft fade/dissolve transition, not the default slide. Need a back gesture/button on the destination.

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

## What's Not Working

(Update as we go.)

- The fade-in on `PlaceholderHomeView` is technically running but visually imperceptible — iOS's launch transition masks it. Not a bug; pattern needs to live somewhere without a launch boundary to read properly. Revisit when applied to in-app transitions.

## Vibes Check

How does the app feel right now? This is the "look at it on the phone" gut check.

Not on the phone yet. First gut check happens at end of Phase 0.

## Recent Decisions

Most recent first. Move to the brief's Decisions Log when stable.

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
        │   └── WordStone.swift
        ├── Screens/
        │   └── PlaceholderHomeView.swift
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
