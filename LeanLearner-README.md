# Lean 4 Learner

A Duolingo-style iPhone app for learning [Lean 4](https://leanprover.github.io) — the interactive theorem prover and functional programming language.

## Features

- **5 curriculum units** covering Lean 4 from scratch to tactics
- **3 exercise types**: multiple choice, fill-in-the-blank, and tap-all-correct
- **XP & streaks** to keep you motivated
- **Hearts system** — 3 per lesson, lose one on each wrong answer
- **Progress tab** with stats on XP, streak, and lessons completed
- Fully offline — no backend required

## Curriculum

| Unit | Topic | Lessons |
|------|-------|---------|
| 1 | Expressions & Types | `#eval`, `#check`, basic types, arithmetic |
| 2 | Functions | `def`, `fun`, arrow types, currying |
| 3 | Pattern Matching | `match`, `if/then/else`, recursive functions |
| 4 | Propositions & Proofs | Propositions as types, `rfl`, `sorry` |
| 5 | Tactics | `intro`, `exact`, `apply`, `simp`, `ring` |

## Requirements

- Xcode 15+
- iOS 17+
- No external dependencies

## Getting Started

1. Clone the repo
2. Open `LeanLearner.xcodeproj` in Xcode
3. Select an iPhone simulator (iPhone 15 or later recommended)
4. Press **⌘R** to build and run

## Architecture

```
LeanLearner/
├── App/             # App entry point and root navigation
├── Models/          # Lesson, Exercise, UserProgress structs
├── ViewModels/      # LessonViewModel, ProgressViewModel
├── Views/
│   ├── Home/        # Course map and lesson cells
│   ├── Lesson/      # Exercise views and lesson flow
│   ├── Progress/    # Stats screen
│   └── Onboarding/  # First-launch onboarding
└── Data/            # All Lean 4 lesson content (static Swift)
```

- **MVVM** with `ObservableObject` + `@EnvironmentObject`
- **Persistence** via `UserDefaults` (no CoreData or network needed)
- **Pure SwiftUI**, iOS 17 minimum, no third-party packages
