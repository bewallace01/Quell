# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 0: Foundation**

Slices 0.1, 0.2, and 0.3 are complete. Next up: Slice 0.4 (App shell + first real screen — `PlaceholderHomeView`).

## Last Session Summary

Built out the full design token system in `Quell/Quell/DesignSystem/`: `QuellColors.swift`, `QuellTypography.swift`, `QuellSpacing.swift`, `QuellMotion.swift`, plus a `TokenPreview` SwiftUI view that renders every token in context. Rebuilt the color palette mid-slice against a bioluminescent-ocean reference image (10 unique colors, two families: cool Moon+Glow, warm Ember+Dawn). Wired Fraunces (display) and Geist (UI/body) from Google Fonts as variable .ttf files in the bundle. `QuellApp.swift` currently launches into `TokenPreview()` as the visual checkpoint.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Slice 0.4: App shell + first real screen.** Create `PlaceholderHomeView` showing the word "quell" in `quellDisplay` (Fraunces Light), centered on `quellMidnight`, with a subtle fade-in on appear. Replace `TokenPreview()` in `QuellApp.swift` with this new view as the actual root.

## Where We Left Off

Repo state:
- Design system tokens shipped and rendering correctly in TokenPreview
- Fraunces and Geist fonts bundled and registered (UIAppFonts in Info.plist)
- `QuellApp.swift` temporarily points at `TokenPreview()` — to be replaced by `PlaceholderHomeView` in Slice 0.4
- Project still has macOS in Supported Destinations (caused a UIKit build error during font debug); needs narrowing to iPhone-only as a small cleanup before Phase 0 closes
- Two reference images at repo root are now `.gitignore`d

Next concrete action: Build `PlaceholderHomeView` per Slice 0.4. Also: narrow Supported Destinations to iPhone (Xcode UI step Bailey does).

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

## What's Not Working

(Update as we go.)

Nothing to break yet.

## Vibes Check

How does the app feel right now? This is the "look at it on the phone" gut check.

Not on the phone yet. First gut check happens at end of Phase 0.

## Recent Decisions

Most recent first. Move to the brief's Decisions Log when stable.

- Fraunces and Geist sourced as variable .ttf files from their official GitHub repos (googlefonts/fraunces, vercel/geist-font), bundled in `Quell/Quell/Fonts/`, and registered via a project `Info.plist` containing `UIAppFonts`. SwiftUI calls use family name + `.weight(...)`. Verified rendering on iOS Simulator.
- Color palette rebuilt against a bioluminescent-ocean reference image. Brand visual concept shifted from "still water at dusk" to "bioluminescent ocean at twilight." Palette is now organized into bases, text, cool family (Moon + Glow), and warm family (Ember + Dawn). Each color has a defined role and rule. quellCalm and quellAlert are now aliases of Moon and Ember rather than independent colors. Total unique colors: 10.
- Display font: Fraunces. UI/body font: Geist. Both Google Fonts, both free, both variable.
- Confirmed iOS 17.0 minimum target (locked in at Xcode project creation).
- Confirmed bundle ID: `com.lightspacelabs.quell` (locked in at Xcode project creation).

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
        ├── QuellApp.swift              (root view: TokenPreview() — temporary)
        ├── ContentView.swift           (default template, unused)
        ├── Item.swift                  (default SwiftData template, unused)
        ├── Info.plist                  (UIAppFonts registration)
        ├── Assets.xcassets/
        ├── DesignSystem/
        │   ├── QuellColors.swift
        │   ├── QuellTypography.swift
        │   ├── QuellSpacing.swift
        │   ├── QuellMotion.swift
        │   └── TokenPreview.swift
        └── Fonts/
            ├── Fraunces.ttf
            └── Geist.ttf
```

Will expand as we build out screens. `ContentView.swift` and `Item.swift` are leftover from the SwiftUI App template and will be deleted once `PlaceholderHomeView` lands.

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
