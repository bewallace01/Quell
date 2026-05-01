# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 1: Home Screen**

Slice 1.1 (BreathingShape) shipped. Working forward through 1.2 ("right now i'm…" prompt), 1.3 (word-stones), 1.4 (placeholder routing).

## Last Session Summary

Closed Slice 1.1. Shipped `BreathingShape` — a radial gradient orb (ember → dawn → moon → midnight, weighted so the warm core sits inside ~22% of the radius and blue dominates from 50% out) with a 4s inhale + 0.4s peak hold + 6s exhale + 1.2s trough rest cycle, animated via `quellEaseGentle` (decelerate curve) on both directions. A subtle `.blur(radius: 6)` placed before `.scaleEffect` makes the orb slightly more diffuse at peak inhale and more defined at trough — the blur breathes with the body. Wired into `PlaceholderHomeView` in place of the "quell" wordmark; the orb is now the home centerpiece. Iteration was tight: gradient went through three-stop variants (moon-midnight, ember-moon-midnight, ember-dawn-moon-midnight) before landing on the four-stop with weighted locations and a dawn intermediary that bridges the warm-cool perceptual jump.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Slice 1.2: "Right now i'm…" prompt.** Place the prompt above the breathing shape, in display font (Fraunces) light weight, `quellCream`, with generous spacing. Subtle fade-in delayed slightly behind the orb's appearance.

## Where We Left Off

Repo state:
- `BreathingShape.swift` lives in `Quell/Quell/Components/` (new folder under the synchronized root group)
- `PlaceholderHomeView` renders `BreathingShape` as its content; the Phase 0 wordmark is retired
- All Phase 0 tokens (colors, typography, spacing, motion) carry forward unchanged
- `BreathingShape` is reusable: single `size: CGFloat = 200` parameter, intended to scale up for the larger co-regulation circle in Slice 2.1

Next concrete action: Slice 1.2 — drop "right now i'm…" above the orb. Use Fraunces (`.quellDisplay`) light weight, `quellCream`, with delayed fade-in (slightly behind the orb's first appearance). Generous vertical spacing.

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

## What's Not Working

(Update as we go.)

- The fade-in on `PlaceholderHomeView` is technically running but visually imperceptible — iOS's launch transition masks it. Not a bug; pattern needs to live somewhere without a launch boundary to read properly. Revisit when applied to in-app transitions.

## Vibes Check

How does the app feel right now? This is the "look at it on the phone" gut check.

Not on the phone yet. First gut check happens at end of Phase 0.

## Recent Decisions

Most recent first. Move to the brief's Decisions Log when stable.

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
        │   └── BreathingShape.swift
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
