# pettyUniversity

A Flutter venting/reflection app inspired by Swoop's "Petty University" series.

## Why I built this

pettyUniversity was inspired by Swoop's Petty University — something my best
friend and I used to watch together. This elective project became a way to
build something fun in Swoop's voice while thinking of her. It's a
lighthearted "venting app" on the surface, with an actual reflection
framework (the Unpack flow) underneath.

## What it does

You open a case, vent, and then get walked through a short "Unpack That"
flow: naming what you actually needed in the moment, locking that need in,
and optionally taking a 2-minute mindfulness pause before going back out
there. Every entry is archived as a case — open if it hasn't been reflected
on yet, closed once it has.

## Stack

- Flutter / Dart
- `provider` for state management
- `shared_preferences` for local persistence
- `google_fonts` (Space Grotesk + Space Mono)

## Getting started

```bash
flutter pub get
flutter run
```

Design reference: `assets/designs/pettyUniversity-compressed.pdf` (Figma
prototype). Export the wallpapers and button assets referenced in that file
into `assets/images/` using the filenames already wired into
`lib/theme/app_constants.dart`.

## Project structure

```
lib/
  main.dart
  theme/            # colors, text styles, layout constants
  models/           # CaseEntry, CaseStatus
  providers/        # CaseProvider (state + persistence)
  screens/          # Home, Cases, Add-Entry
    unpack/          # The "Unpack That" reflection flow + mindfulness timer
  widgets/          # Shared UI (GlassContainer, etc.)
assets/
  designs/          # Figma prototype PDF
  images/           # Wallpapers + button PNGs exported from Figma
```

## Build log

Built over 5 days as a series of scoped GitLab issues — see the project
board for the day-by-day breakdown (Setup & Architecture → Navigation &
Core Logic → Unpack Flow → Mindfulness Pause → Polish & Testing).
