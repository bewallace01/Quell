# MEMORY.md

> Living context for Claude Code. Read at the start of every session. Update at the end of every session. This is how we maintain continuity across conversations.

---

## Current Phase

**Phase 0: Foundation**

We have not started coding yet. This is the pre-flight state.

## Last Session Summary

No sessions yet. Project brief and task list just created.

## Active Slice

The current vertical slice we are building. We do not start a new slice until this one is checkpointed and feels right.

**Slice:** None yet. Next slice will be **Phase 0, Slice 1: Xcode project setup + design tokens file.**

## Where We Left Off

Project files created:
- `QUELL_PROJECT_BRIEF.md` (the source of truth)
- `MEMORY.md` (this file)
- `TASKS.md` (the live checklist)

Next concrete action: Open Xcode, create a new SwiftUI project named "Quell," commit to git, and create the design tokens Swift file.

## Open Questions

Things we have not decided yet but will need to soon. Each has a "decide by" phase.

- **App icon design.** Decide by Phase 12. Direction: a single soft wave curve or glowing circle on dark background. Abstract. Inconspicuous.
- **Display font license.** Decide by Phase 1. Tiempos Text and GT Alpina are paid; need to verify license cost or pick a free alternative (e.g., a system serif or Google Fonts option like Fraunces).
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

- (Pending Phase 0) Confirmed iOS 17.0 minimum target.
- (Pending Phase 0) Confirmed bundle ID format: `com.lightspacelabs.quell`.

## File Structure (current)

```
quell/
├── QUELL_PROJECT_BRIEF.md
├── MEMORY.md
└── TASKS.md
```

Will expand as we build the Xcode project.

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
