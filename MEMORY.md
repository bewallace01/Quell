# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 0: Foundation**

All four slices (0.1 pre-flight, 0.2 Xcode project, 0.3 design tokens, 0.4 app shell + PlaceholderHomeView) are complete. Phase 0 closeout is the only remaining work before Phase 1.

## Last Session Summary

Closed out Slice 0.4: built `PlaceholderHomeView` showing "quell" in Fraunces Light on `quellMidnight`, rewired `QuellApp.swift` to use it as the actual root, stripped the SwiftData scaffolding (no longer needed in v1; Pattern Detective storage is Phase 8 work), and deleted the orphan template files (`ContentView.swift`, `Item.swift`). The app now launches directly into the brand surface. Fade-in is implemented but iOS's launch sequence masks the animation visually — flagged for revisit when the pattern lives somewhere without a launch boundary.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Phase 0 Closeout.** Update Decisions Log in the brief if anything new, screenshot the placeholder for posterity, decide whether ready for Phase 1.

## Where We Left Off

Repo state:
- Design system tokens shipped (colors, typography, spacing, motion) and rendering correctly
- Fraunces and Geist fonts bundled and registered
- `QuellApp.swift` is clean (no SwiftData), launches directly into `PlaceholderHomeView`
- Template scaffolding (`ContentView.swift`, `Item.swift`) deleted
- Supported Destinations narrowed to iPhone only
- Reference images gitignored

Next concrete action: Phase 0 closeout — confirm decisions log is current, capture screenshot, then decide on Phase 1 entry. Phase 1 starts with Slice 1.1 (BreathingShape).

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
- `PlaceholderHomeView` ships as the app's actual root: "quell" in Fraunces Light, centered on `quellMidnight`. Brand presence on first launch.

## What's Not Working

(Update as we go.)

- The fade-in on `PlaceholderHomeView` is technically running but visually imperceptible — iOS's launch transition masks it. Not a bug; pattern needs to live somewhere without a launch boundary to read properly. Revisit when applied to in-app transitions.

## Vibes Check

How does the app feel right now? This is the "look at it on the phone" gut check.

Not on the phone yet. First gut check happens at end of Phase 0.

## Recent Decisions

Most recent first. Move to the brief's Decisions Log when stable.

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
