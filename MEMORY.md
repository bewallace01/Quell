# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 0: Foundation**

Slices 0.1 (pre-flight setup) and 0.2 (Xcode project creation) are complete. Now actively in Slice 0.3 (design token system).

## Last Session Summary

Pre-flight work done outside of Claude sessions: Xcode installed, Apple ID signed in, GitHub repo set up, Xcode project created at `Quell/Quell.xcodeproj`, `.gitignore` in place, initial commits pushed. Planning files (`QUELL_PROJECT_BRIEF.md`, `MEMORY.md`, `TASKS.md`) live at project root.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Slice 0.3: Design token system.** Build out `Quell/DesignSystem/` with `QuellColors.swift`, `QuellTypography.swift`, `QuellSpacing.swift`, `QuellMotion.swift`, then a `TokenPreview` SwiftUI view that renders every token side by side. Visual checkpoint: Bailey looks at the preview screen and approves the palette in context.

## Where We Left Off

Repo state:
- Xcode project exists at `Quell/Quell.xcodeproj`
- `.gitignore` configured
- Planning files committed at project root
- No design system code yet

Next concrete action: Create the `Quell/DesignSystem/` group and start with `QuellColors.swift` (Color extensions for every token in the brief).

## Open Questions

Things we have not decided yet but will need to soon. Each has a "decide by" phase.

- **App icon design.** Decide by Phase 12. Direction: a single soft wave curve or glowing circle on dark background. Abstract. Inconspicuous.
- **Bundle identifier.** Decide at Phase 0 setup. Suggested: `com.lightspacelabs.quell`
- **App Store name reservation.** Decide before Phase 12. Confirm Quell is available in App Store Connect (requires Apple Developer account).
- **Clinical advisor.** Decide by Phase 12. Outreach can begin earlier; ideally have someone signed before TestFlight.
- **Pricing model.** Decide by Phase 12. Options: free with optional one-time unlock, freemium with subscription, fully free. Lean toward free in beta, decide before App Store launch.

## What's Working

(Update as we go.)

Nothing built yet.

## What's Not Working

(Update as we go.)

Nothing to break yet.

## Vibes Check

How does the app feel right now? This is the "look at it on the phone" gut check.

Not on the phone yet. First gut check happens at end of Phase 0.

## Recent Decisions

Most recent first. Move to the brief's Decisions Log when stable.

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
    └── Quell.xcodeproj
```

Will expand as we build out the design system and screens.

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
