# pettyUniversity

*A Flutter app for venting with a purpose — inspired by Swoop's "Petty University."*

---

## Table of Contents

- [Why I Built This](#why-i-built-this)
- [What It Does](#what-it-does)
- [How the Flow Works](#how-the-flow-works)
- [Screens](#screens)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Design Reference](#design-reference)
- [Build Process](#build-process)
- [Acknowledgments](#acknowledgments)

---

## Why I Built This

pettyUniversity was inspired by Swoop's "Petty University" series — something my best friend and I used to watch together. This elective project became a way to build something fun in Swoop's voice while thinking of her. It's a lighthearted "venting app" on the surface, with an actual reflection framework (the Unpack flow) underneath, built to show what I learned across the Flutter and Dart tracks for this elective.

## What It Does

pettyUniversity gives you a space to vent — no filter, no judgment — and then, once you've gotten it out, gently walks you through figuring out what you actually needed in that moment. Every entry is logged as a "case." Cases stay **open** until you've done the reflection, and flip to **closed** once you've named the need behind the noise. Nothing here is meant to be re-read for the drama of it — it's meant to be closed out and set down.

An optional 2-minute mindfulness pause caps off each reflection, because taking a moment to actually sit with your feelings, distraction-free, is genuinely good for you — not just a bit.

## How the Flow Works

1. **Vent it out** — Open a new case and write freely.
2. **Decide if it's worth unpacking** — Some things are worth reflecting on right now; some can wait ("leaving it sitting in the hallway").
3. **Name the actual need** — Strip away the petty details and pick (or write in) what you were really needing: basic respect, an apology, a moment to breathe, or just a snack and a nap.
4. **Lock it in** — The case closes, and the need is recorded permanently alongside the entry.
5. **Optional: ground yourself** — Take a 2-minute mindfulness pause before going back out there, or skip it if you're good.

## Screens

| Screen | Purpose |
|---|---|
| **Home** | Landing screen — jump into a new entry or check past cases |
| **Add-Entry (open)** | Where you vent; save, exit, or discard the entry |
| **Add-Entry (closed)** | Read-only view of a reflected-on case, including the need you named |
| **Unpack Prompt** | Decide whether to unpack the entry now or later |
| **Name the Need** | Transition screen into naming what you actually needed |
| **Select Needs** | Checklist of common needs, plus a free-text "Other" option |
| **Mindfulness Prompt** | Offers a 2-minute breathing pause before closing out |
| **Mindfulness Timer** | Live countdown, resets to "Reset Complete" when done |
| **Cases** | Full archive of all cases, filterable by open/closed ("CLASSIFIED RECEIPTS") |

## Tech Stack

- **Flutter / Dart**
- [`provider`](https://pub.dev/packages/provider) — state management
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) — local persistence for cases
- [`google_fonts`](https://pub.dev/packages/google_fonts) — Space Grotesk + Space Mono, per the design spec

## Project Structure

```
lib/
  main.dart              # App entry point, routing, provider setup
  theme/
    app_theme.dart        # Colors + text styles (Space Grotesk / Space Mono)
    app_constants.dart     # Corner radius, glass-effect values, wallpaper paths
  models/
    case_entry.dart        # CaseEntry model + CaseStatus enum
  providers/
    case_provider.dart      # Case state, ID generation, persistence
  screens/
    home_screen.dart
    cases_screen.dart
    add_entry_screen.dart
    unpack/
      unpack_prompt_screen.dart
      name_need_screen.dart
      select_needs_screen.dart
      mindfulness_prompt_screen.dart
      mindfulness_timer_screen.dart
  widgets/
    glass_container.dart    # Reusable glassmorphic container
assets/
  designs/                 # Original Figma prototype (PDF)
  images/                  # Wallpapers + button assets exported from Figma
```

## Getting Started

```bash
git clone <your-repo-url>
cd petty_university
flutter pub get
flutter run
```

Requires a working Flutter SDK (`flutter doctor` should come back clean) and either a connected device or an emulator/simulator running.

## Design Reference

The full visual spec — colors, corner radius (`51`), glassmorphism values (refraction/depth/dispersion/frost/splay), fonts, and screen-by-screen breakdowns — was prototyped in Figma first. That prototype is included at `assets/designs/pettyUniversity-compressed.pdf` for reference, and the wallpapers/button assets referenced throughout the app were exported from it into `assets/images/`.

## Build Process

Scoped GitLab issues, tracked through Backlog → Ready for Dev → In Dev → In Testing → Ready for Showcase:

1. **Setup & Base Architecture** — project init, theme system, data models
2. **Navigation & Core Logic** — routing, Home and Cases screens
3. **The "Unpack That" Reflection Flow** — entry screens, need-naming flow
4. **Mindfulness Pause** — the breathing timer, end-to-end wiring, persistence
5. **Swoop Polish, Styling & Final Testing** — glass effects, filtering, QA pass

## Acknowledgments

Named after and inspired by [Swoop](https://www.youtube.com/@Swoop)'s "Petty University" — thank you for the concept, and to my best friend, for all the episodes we watched together.