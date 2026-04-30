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

- [ ] Create `Quell/DesignSystem/` folder in project
- [ ] Create `QuellColors.swift` with all color tokens from the brief, as Color extensions
- [ ] Create `QuellTypography.swift` with all type tokens as Font extensions
- [ ] Create `QuellSpacing.swift` with spacing constants
- [ ] Create `QuellMotion.swift` with animation/duration constants
- [ ] Create a small `TokenPreview` SwiftUI view that displays every color, font, and spacing value side by side
- [ ] **Visual checkpoint:** the token preview screen renders all tokens correctly. Bailey looks at it and approves the palette in context.

### Slice 0.4: App shell and first real screen

- [ ] Replace default ContentView with a `QuellApp` root view
- [ ] Set the app's background to `quellMidnight`
- [ ] Create `PlaceholderHomeView.swift` showing just the word "quell" in display font, centered, on midnight background
- [ ] Add subtle fade-in animation on appear
- [ ] **Visual checkpoint:** the app launches, shows "quell" softly fading in on a deep slate background. Feels quiet, intentional.

### Slice 0.5: First device test (optional but recommended)

- [ ] Enroll in Apple Developer Program if not done
- [ ] Connect iPhone, trust the Mac
- [ ] Build and run on actual device
- [ ] **Visual checkpoint:** Bailey holds the phone, opens the app, sees the brand. This is the moment to feel whether the foundation is right.

### Phase 0 Closeout

- [ ] Update `MEMORY.md` with Phase 0 summary
- [ ] Update Decisions Log in brief with anything new
- [ ] Take a screenshot of the placeholder screen for posterity
- [ ] Decide: ready for Phase 1?

---

## Phase 1: Home Screen

**Goal:** The doorway. The animated breathing shape, "right now i'm…" prompt, and four word-stones (Steady, Wobbling, In it, Need company).

**Done when:** You open the app, see the breathing shape pulsing at a real breath cycle, see the four word-stones floating, and tapping any one of them navigates to a placeholder destination.

### Slice 1.1: Breathing shape

- [ ] Create `BreathingShape.swift` — a custom SwiftUI view
- [ ] Render a soft circle/orb using a radial gradient from `quellMoon` center to `quellMidnight` edge
- [ ] Animate scale and opacity in a 4s inhale / 6s exhale loop using `quellEaseSlow`
- [ ] Make sure the animation is continuous and never jarring
- [ ] **Visual checkpoint:** stare at it for 30 seconds. Does it feel calming or annoying? Adjust until calming.

### Slice 1.2: "Right now i'm…" prompt

- [ ] Add the prompt above the breathing shape in display font, light weight
- [ ] Use `quellCream` color
- [ ] Generous spacing above and below
- [ ] Subtle fade-in on app launch, slightly delayed from the shape's appearance
- [ ] **Visual checkpoint:** prompt feels like a gentle invitation, not a question being demanded.

### Slice 1.3: The four word-stones

- [ ] Create `WordStone.swift` — a reusable button that looks like a soft floating word, not a button
- [ ] Layout: four word-stones below the breathing shape — Steady · Wobbling · In it · Need company
- [ ] Each tap should give a soft haptic and a brief visual response (gentle scale, glow with `quellGlow`)
- [ ] Test the touch targets are large enough (min 44pt)
- [ ] **Visual checkpoint:** tap each one. Does the response feel warm? Or does it feel like a button click? Adjust.

### Slice 1.4: Placeholder routing

- [ ] Each word-stone navigates to a placeholder screen showing just the word it represents
- [ ] Use a soft dissolve transition, not a slide
- [ ] Add a small back gesture or button to return to home
- [ ] **Visual checkpoint:** the navigation feels like water. No sharp edges.

### Phase 1 Closeout

- [ ] Update MEMORY.md
- [ ] Vibes check: open the app cold and use it for 60 seconds. Does it feel like Quell?
- [ ] Decide: ready for Phase 2?

---

## Phase 2: Urge Flow

**Goal:** The heart of the app. The "In it" path leads to 60-second co-regulation, then the Fork (Body / Mood / Don't know), then one full route end-to-end (Mood → Anxious), then the Wave Check.

**Done when:** A real user can tap "In it" during a real urge and the app actually helps them through the next 5-10 minutes.

### Slice 2.1: The 60-second co-regulation screen

- [ ] On "In it" tap, fade screen to near-black over 800ms
- [ ] Display "i'm here. breathe with me." in display font, slow fade-in
- [ ] Show breathing circle, larger than home screen version
- [ ] No buttons for first 8 seconds
- [ ] After 8 seconds, soft "stay" / "skip ahead" buttons fade in
- [ ] **Visual checkpoint:** time it. Sit through the 8 seconds. Does the pause feel right or punishing?

### Slice 2.2: Wren's first voice (text-based)

- [ ] Create `WrenLine.swift` — a styled text component for Wren's voice
- [ ] Implement a small set of co-regulation phrases that rotate
- [ ] Phrases display one at a time during the breathing loop
- [ ] Slow fade between phrases
- [ ] **Visual checkpoint:** read the phrases as a stranger would. Do they feel warm or clinical?

### Slice 2.3: The Fork

- [ ] Create `ForkView.swift` — three soft shapes in triangle layout
- [ ] Top: Body. Lower left: Mood. Lower right: Don't know.
- [ ] Tap reveals label, second tap commits
- [ ] Each fork option fades in over 400ms
- [ ] **Visual checkpoint:** does the three-option layout feel like a real choice or overwhelming? Test with no labels first.

### Slice 2.4: Mood route — Anxious protocol

- [ ] Mood tap → six word-bubbles: Anxious, Lonely, Tired, Bored, Numb, Rage
- [ ] Anxious tap → 2-3 minute physiological sigh + grounding exercise
- [ ] Build the protocol screen with breathing pacing, gentle text guidance
- [ ] Include a "this isn't helping, try something else" option that returns to the Fork
- [ ] **Visual checkpoint:** do the full protocol. Does it actually feel like it would help during real anxiety?

### Slice 2.5: The Wave Check

- [ ] After protocol, soft transition to Wave Check screen
- [ ] One horizontal slider: bigger ← same → smaller, no numbers
- [ ] Three branches based on result
- [ ] If smaller: brief acknowledgment, optional debrief
- [ ] If same: "want to try a different tool?" → back to Fork
- [ ] If bigger: "let's escalate" → Co-pilot mode placeholder + crisis resources visible
- [ ] **Visual checkpoint:** the slider should feel like a feeling, not a survey question.

### Slice 2.6: The Debrief

- [ ] Three skippable prompts: trigger, what helped, what to tell future-you
- [ ] Save quietly to local storage (we'll formalize storage in Phase 8)
- [ ] No score, no verdict, just a soft "thanks for showing up"

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

- [ ] Body fork tap → "what does your body actually want?"
- [ ] Five sensory icons: crunch, cold, warm, sweet, salty
- [ ] Abstract texture squares, no food images

### Slice 4.2: Sensory Swaps content model

- [ ] Define the data structure for a Swap entry (sensory category, type [food/non-food], description, why it works)
- [ ] Build first 50 entries hand-curated across all five categories
- [ ] Store as local JSON for v1

### Slice 4.3: Browse and detail views

- [ ] Browse view: scrollable list filtered by sensory category
- [ ] Detail view: expanded entry with the "why" copy
- [ ] No ratings, no favorites in v1 — keep it simple

### Slice 4.4: Eat Anyway entry from Body route

- [ ] If user wants food: "sounds good. want to slow it down a little?"
- [ ] Two soft buttons: "yes, walk me through it" / "just eat, i'll check back"
- [ ] (Full Eat Anyway logic in Phase 5)

---

## Phase 5: Eat Anyway Mode

**Goal:** The philosophical centerpiece. Eating becomes data, not failure.

### Slice 5.1: Mindful path

- [ ] "Take it somewhere you can sit. Phone face-down. Eyes on the food. First three bites, just notice."
- [ ] Optional 10-minute soft timer
- [ ] Gentle check-in at end

### Slice 5.2: Just-eat path

- [ ] "I'm here when you're ready. No pressure."
- [ ] Ambient screen with breathing circle
- [ ] Soft return ping after 20 minutes (local notification)

### Slice 5.3: Post-eat debrief

- [ ] "How are you?" — single soft prompt
- [ ] Optional: trigger tag, one line of reflection
- [ ] No food details captured. Ever.

### Slice 5.4: Eat Anyway access points

- [ ] Available from Body route
- [ ] Available from anywhere via long-press on Wren's presence
- [ ] **This must be the easiest feature to find when someone is going to eat regardless. Test the access path under pressure.**

---

## Phase 6: Remaining Mood Routes + Don't Know

### Slice 6.1: Lonely protocol

- [ ] Future Self voice note placeholder + "anchor person" Messages-app handoff

### Slice 6.2: Tired protocol

- [ ] Permission slip to rest + 4-minute power-down

### Slice 6.3: Bored protocol

- [ ] Boring Meeting Protocol entry (full version in Phase 9) + 90-second curiosity prompt

### Slice 6.4: Numb protocol

- [ ] Body scan + gentle re-entry exercise

### Slice 6.5: Rage protocol

- [ ] Somatic shake-off video/animation + private rage-typing pad that auto-deletes

### Slice 6.6: Don't Know — body scan flow

- [ ] 90-second guided scan: head, jaw, chest, stomach, hands, feet
- [ ] One tap per area: tight / neutral / open
- [ ] Soft suggestion at end, user can accept or override

---

## Phase 7: Future Self Voice Notes

### Slice 7.1: Recording UI

- [ ] Soft recording interface, max 60 seconds per note
- [ ] Up to 5 notes stored locally
- [ ] Title + date metadata

### Slice 7.2: Playback during urges

- [ ] Surface during co-regulation if user has notes saved
- [ ] Randomized selection
- [ ] User can skip without judgment

### Slice 7.3: Management

- [ ] List, listen, delete, re-record
- [ ] No cloud sync. Local only.

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

- [ ] One-tap entry from anywhere
- [ ] Screen looks like a notes app or blank document
- [ ] Hand fidget prompts (text-based, scrollable)
- [ ] Silent isometric desk exercises (text instructions)
- [ ] Invisible breathing patterns (haptic only, no visible animation)

### Slice 9.2: Quick exit

- [ ] Tap anywhere to return to home, no friction

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

- [ ] Shake phone or double-tap back → instant switch to neutral notes-app-looking screen
- [ ] Return on tap

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

- [ ] First-launch flow: Wren introduces itself, philosophy stated softly, no questionnaire
- [ ] Optional opt-ins for notifications, haptics, audio
- [ ] Crisis resources mentioned naturally

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

---

*This file is the live checklist. Update statuses as we go. Add slices when scope clarifies. Remove or descope when we find ourselves dragging.*
