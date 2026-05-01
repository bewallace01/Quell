# QUELL — Project Brief

> Read this file at the start of every Claude Code session. It is the source of truth for what Quell is, who it's for, and how we build it.

---

## What Quell Is

Quell is an iOS app for people who deal with binge eating, constant urges to snack, and the shame spiral that comes with both. It is anti-restriction, anti-shame, and anti-calorie-counting. It is grounded in Intuitive Eating, Health at Every Size (HAES), and Acceptance and Commitment Therapy (ACT).

The core insight: shame and restriction fuel binges. Permission and self-compassion reduce them. Every UX decision flows from this.

The companion voice inside the app is named **Wren** — small, warm, present, never preachy.

**Tagline:** *for when it's loud.*

## What Quell Is Not

These are non-negotiable. They are not "v1 cuts" — they are never-features.

- No calorie counting
- No weight tracking
- No food logging by quantity or macros
- No body composition
- No streaks that punish setbacks
- No good/bad food framing
- No before/after content
- No willpower or discipline language
- No clinical/diagnostic tone
- No cheerleading ("Great job!", "You've got this!")
- No exclamation points unless something genuinely warrants one (almost never)

If a feature request would require any of the above, the answer is no.

## Who Quell Is For

The primary user: someone who has tried calorie-counting apps and felt worse, has a complicated relationship with food, often eats in response to emotion or boredom or exhaustion, frequently feels shame after eating, and is tired of being told to white-knuckle through it.

Secondary user: desk workers and remote workers who snack out of boredom, stress, or restlessness during long stretches of low-stimulation work.

Tertiary: people in early ED recovery looking for tools that don't reinforce restriction. (The app is a supplement to professional care, never a replacement. This must be explicit in onboarding and About copy.)

## The Brand

**Name:** Quell. Means to suppress, subdue, bring something fierce down to calm. The verb does the brand work.

**Companion voice:** Wren. A wren is small but its song cuts through. The app's voice presence — text first, audio later — is named Wren and has a consistent persona.

**Voice and tone:** Warm, low, unhurried. Lowercase often. Contractions always. Friend who's been there, not clinician, not coach. Says "yeah" and "hey." Never preachy. Never peppy.

**Sample copy:**
- "hey. i'm here. breathe with me for a sec."
- "you don't have to fight this. just stay with me."
- "wave's gonna pass. it always does."
- "no verdict. just data. you're doing the work by being here."

**Visual concept:** Bioluminescent ocean at twilight. The threshold hour when day has just gone but the world is alive with quiet light. Polar tension between cool electric glow and warm horizon ember, held in deep blue dark. Light emerges from within the darkness — directly metaphorical for what the app helps the user do.

**Inconspicuous by design:** App must pass the home-screen test (icon and name reveal nothing), the shoulder-surf test (a glance reveals nothing diagnostic), and the notification test (push copy reads like a friend texting, never like a clinical alert).

## Design Tokens

These are referenced everywhere. Change a token, change the whole app. Never hard-code values.

### Colors

```
// Bases
quellMidnight  #0B1220   deep night, the silhouette against the sky
quellDeep      #131C2E   water away from the glow
quellShade     #1C2638   elevated surfaces

// Text
quellCream     #F2EBDD   primary text, warm cream — never pure white
quellMist      #A0AAC0   secondary text, cool gray-blue
quellWhisper   #565F76   tertiary text, very subtle

// Cool family
quellMoon      #4A8FB5   calm steel-blue, always-there primary accent
quellGlow      #2585D4   electric bioluminescent blue, active states only

// Warm family
quellEmber     #D85A30   sunset-band orange, charged/rare human warmth
quellDawn      #E8946A   diffused warm, routine warmth

// Functional
quellCalm      = quellMoon   (#4A8FB5)
quellAlert     = quellEmber  (#D85A30)
```

### Color roles and rules

Each color has a clear job. Don't reach for a color outside its role.

- Midnight/Deep/Shade: the world. Three steps of dark, used as backgrounds, surfaces, elevated cards.
- Cream/Mist/Whisper: the words. Three steps of text from primary to barely-there.
- Moon: the calm primary accent. Always-there. Used for buttons, the breathing shape's resting state, navigation indicators.
- Glow: the active state. Appears only when something is *actually happening* — taps, transitions, breathing-circle pulses, the moment a co-regulation begins. Never decorative.
- Ember: rare and charged. The color of human warmth in dark places. Reserved for moments that matter — Wren's most intimate copy, the Future Self voice note marker, the small glow that says 'you came back.' If your eye lands on something Embered, that moment matters.
- Dawn: routine warmth. The diffused, softer warm. Appears in regular UI where something needs to feel held without being charged.

The cool family (Moon, Glow) and the warm family (Ember, Dawn) carry polar tension. The brand lives in the space between.

### Typography

- **Display** (presence moments, short evocative phrases): Fraunces (Google Fonts, free, variable weights). Light weight, large size, generous line height.
- **UI** (buttons, labels, nav): Geist (Google Fonts, free, variable weights). Regular/Medium weight.
- **Body** (longer reading): Geist (same as UI for consistency). Line height 1.6+.

When in doubt: smaller and lighter. The brand never shouts.

### Spacing

```
quellSpace1   4pt
quellSpace2   8pt
quellSpace3   12pt
quellSpace4   16pt
quellSpace5   24pt
quellSpace6   32pt
quellSpace7   48pt
quellSpace8   64pt
```

Generous breathing room is part of the brand.

### Motion

```
quellEaseGentle   cubic-bezier(0.4, 0.0, 0.2, 1.0)
quellEaseSlow     cubic-bezier(0.25, 0.1, 0.25, 1.0)
quellDurFast      200ms   tap feedback
quellDurMid       400ms   standard transitions
quellDurSlow      800ms   screen transitions
quellDurBreath    4000ms  inhale
quellDurExhale    6000ms  exhale (longer, parasympathetic)
```

Everything moves like water. Slow easing curves, never snappy. Transitions dissolve, not slide.

### Sound (later phases)

- `quellChime`: soft single low-frequency tone for completion moments
- `quellPulse`: subtle haptic paced to breath cycle
- `quellBell`: distant two-tone for notifications

Default to silence. Audio routes through earbuds only by default.

## Technical Stack

- **Platform:** iOS only for v1
- **Language:** Swift
- **Framework:** SwiftUI
- **Minimum iOS:** iOS 17.0 (gives us the modern animation/observation APIs)
- **IDE:** Xcode (latest stable)
- **Source control:** Git
- **No third-party dependencies** in v1 unless absolutely necessary. Native everything.

Android is a v2+ problem. Cross-platform frameworks are off the table — animation feel is core to the product.

## Working Principles

We build this app the way the app teaches users to live: one moment at a time, with permission to pause, no streaks, no shame.

**One vertical slice at a time.** Build one screen completely — visual, interaction, animation, edge cases — until it feels right. Then move on. Never have 30 half-finished screens.

**Visual checkpoints constantly.** After every meaningful change, run it on the phone or simulator and look at it. If it doesn't feel right, fix it before adding anything else. Polish as we go, never "we'll polish later."

**Working build always.** The app is always launchable, always navigable, even if most screens are placeholders. Progress must be tangible.

**The kill switch.** If a piece is dragging past two work sessions and not coming together, stop, rescope, simplify. Done is better than perfect. A smaller thing that works beats a bigger thing that doesn't.

**Tokens not values.** Never hard-code a color, font, spacing, or duration. Always reference a design token. This is how we keep visual consistency without remembering anything.

**ADHD-aware development.** Sessions are bounded. We finish the slice we started. We don't open three new files when one is half-done. We don't refactor things that work. We make progress visible.

## Phase Plan

See `TASKS.md` for the live checklist. High-level arc:

- **Phase 0:** Foundation — Xcode project, design system, navigation shell, one placeholder screen on the phone
- **Phase 1:** Home screen — breathing shape, "right now i'm…", four word-stones
- **Phase 2:** Urge flow — co-regulation, the Fork, one full route end-to-end (Mood → Anxious), Wave Check
- **Phase 3:** Wren — companion voice system across the app
- **Phase 4:** Sensory Swaps + Body route
- **Phase 5:** Eat Anyway mode
- **Phase 6:** Remaining Mood routes + Don't Know route
- **Phase 7:** Future Self voice notes
- **Phase 8:** Pattern Detective (basic)
- **Phase 9:** Boring Meeting Protocol
- **Phase 10:** Anti-streak heat map + settings + crisis resources
- **Phase 11:** Stealth features (quick-blur, disguise mode, notification copy)
- **Phase 12:** Polish + TestFlight
- **Phase 13:** App Store submission

## Safety and Compliance

- The app is a supplement to professional ED care, never a replacement. State this in onboarding and About.
- Crisis resources (NAED helpline, 988) must be accessible from anywhere in the app within two taps.
- Never name, list, or describe specific binge methods or restrictive behaviors as "examples" anywhere in copy or content.
- App Store Review Guideline 1.4.1 applies — eating disorder content is scrutinized. Clinical advisor on the masthead before submission.
- Privacy: all urge logs and Future Self recordings stored locally on device. No cloud sync in v1. No analytics on user content. Crash analytics only, opt-in.

## Decisions Log

Major decisions made and why. Add to this when something changes.

- **Name: Quell** (chosen over Tide due to App Store conflict with existing meditation app, over Eddy due to ED shorthand association, over Anchor due to less distinctive ownability).
- **Companion voice: Wren** (small bird whose song cuts through — metaphor for a small voice helping quell a loud one).
- **iOS-only v1** (animation feel is core; solo founder ships faster on one platform; iOS demographics align with target user willingness to pay).
- **No calorie tracking, ever** (philosophical core; also App Store ED-content safety).
- **No streaks** (binary-thinking trap that fuels shame spirals).

---

End of brief. See `MEMORY.md` for ongoing context and `TASKS.md` for the current work.
