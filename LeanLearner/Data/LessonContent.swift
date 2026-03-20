// swiftlint:disable line_length
import Foundation

/// All static Lean 4 lesson content.
enum LessonContent {
    static let course = Course(
        title: "Learn Lean 4",
        tagline: "From zero to proofs, one lesson at a time.",
        units: [unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8]
    )
}

// MARK: - Unit 1: Expressions & Types

private let unit1 = Unit(
    title: "Expressions & Types",
    icon: "number",
    color: "blue",
    lessons: [
        Lesson(id: "u1l1", title: "#eval and #check", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What does `#eval` do in Lean 4?",
                codeSnippet: "#eval 2 + 3",
                options: ["Declares a function", "Evaluates an expression and prints the result", "Checks the type of an expression", "Imports a library"],
                correctIndex: 1,
                explanation: "`#eval` evaluates an expression and shows its value in the infoview. Here it prints `5`."
            )),
            Exercise(kind: .multipleChoice(
                question: "What does `#check` show you?",
                codeSnippet: "#check 42",
                options: ["The value of the expression", "The type of the expression", "Whether the expression is a theorem", "The memory usage"],
                correctIndex: 1,
                explanation: "`#check 42` shows `42 : Nat` — the expression and its inferred type."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the command to evaluate the string \"Hello, Lean!\"",
                codePrefix: "",
                codeSuffix: " \"Hello, Lean!\"",
                answer: "#eval",
                hint: "Use the command that evaluates and prints an expression."
            )),
        ]),

        Lesson(id: "u1l2", title: "Basic Types", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "Which type represents non-negative whole numbers in Lean 4?",
                codeSnippet: nil,
                options: ["Int", "Float", "Nat", "UInt32"],
                correctIndex: 2,
                explanation: "`Nat` is the type of natural numbers (0, 1, 2, …). `Int` allows negatives."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which of the following are valid Lean 4 expressions of type `Bool`?",
                options: ["true", "false", "1", "\"yes\""],
                correctIndices: [0, 1],
                explanation: "`true` and `false` are the two values of type `Bool`. `1` is `Nat` and `\"yes\"` is `String`."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "What type annotation completes this to declare x as a natural number?",
                codePrefix: "def x : ",
                codeSuffix: " := 7",
                answer: "Nat",
                hint: "The type of 0, 1, 2, 3, … in Lean 4."
            )),
        ]),

        Lesson(id: "u1l3", title: "Arithmetic", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What does this expression evaluate to?",
                codeSnippet: "#eval 10 - 3",
                options: ["7", "-3", "13", "Error"],
                correctIndex: 0,
                explanation: "Subtraction on `Nat` is defined. `10 - 3 = 7`."
            )),
            Exercise(kind: .multipleChoice(
                question: "What is `3 - 5` when both operands are `Nat`?",
                codeSnippet: "#eval (3 : Nat) - 5",
                options: ["-2", "0", "2", "Error"],
                correctIndex: 1,
                explanation: "`Nat` subtraction is *truncated*: `3 - 5 = 0` because natural numbers can't be negative."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Complete the expression to compute 2 to the power of 8.",
                codePrefix: "#eval 2 ^ ",
                codeSuffix: "",
                answer: "8",
                hint: "The exponent goes after `^`."
            )),
        ]),
    ]
)

// MARK: - Unit 2: Functions

private let unit2 = Unit(
    title: "Functions",
    icon: "function",
    color: "green",
    lessons: [
        Lesson(id: "u2l1", title: "def and fun", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "Which keyword defines a named function in Lean 4?",
                codeSnippet: nil,
                options: ["fn", "func", "def", "fun"],
                correctIndex: 2,
                explanation: "`def` defines a named declaration. `fun` creates an anonymous function (lambda)."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the keyword to define a named function `double`.",
                codePrefix: "",
                codeSuffix: " double (n : Nat) : Nat := n * 2",
                answer: "def",
                hint: "The keyword for named definitions in Lean 4."
            )),
            Exercise(kind: .multipleChoice(
                question: "What does this anonymous function do?",
                codeSnippet: "fun x => x + 1",
                options: ["Multiplies x by itself", "Returns x unchanged", "Adds 1 to x", "Subtracts 1 from x"],
                correctIndex: 2,
                explanation: "`fun x => x + 1` is a lambda that takes `x` and returns `x + 1`."
            )),
        ]),

        Lesson(id: "u2l2", title: "Arrow Types", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What is the type of a function from `Nat` to `Bool`?",
                codeSnippet: nil,
                options: ["Bool → Nat", "Nat → Bool", "Nat : Bool", "Bool Nat"],
                correctIndex: 1,
                explanation: "Function types use `→`. `Nat → Bool` is a function taking a `Nat` and returning a `Bool`."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Complete the type signature for a function that takes two `Nat`s and returns a `Nat`.",
                codePrefix: "def add (a b : Nat) : ",
                codeSuffix: " := a + b",
                answer: "Nat",
                hint: "The return type goes after the colon."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which of the following are valid function type expressions in Lean 4?",
                options: ["Nat → Nat", "String → Bool", "Int → Int → Int", "42 → Nat"],
                correctIndices: [0, 1, 2],
                explanation: "`42 → Nat` is invalid because `42` is a value, not a type. The others are valid function types."
            )),
        ]),

        Lesson(id: "u2l3", title: "Currying", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "In Lean 4, a function of two arguments is really…",
                codeSnippet: "def add (a : Nat) (b : Nat) : Nat := a + b",
                options: [
                    "A tuple-taking function",
                    "A function returning another function",
                    "A special two-argument construct",
                    "Invalid — use tuples instead",
                ],
                correctIndex: 1,
                explanation: "Lean 4 uses currying. `add` has type `Nat → Nat → Nat`: it takes one `Nat` and returns a function `Nat → Nat`."
            )),
            Exercise(kind: .multipleChoice(
                question: "What does `add 3` evaluate to if `add : Nat → Nat → Nat`?",
                codeSnippet: nil,
                options: ["3", "A function Nat → Nat", "An error", "0"],
                correctIndex: 1,
                explanation: "Partial application! `add 3` returns a new function that adds 3 to its argument."
            )),
        ]),
    ]
)

// MARK: - Unit 3: Pattern Matching

private let unit3 = Unit(
    title: "Pattern Matching",
    icon: "arrow.triangle.branch",
    color: "orange",
    lessons: [
        Lesson(id: "u3l1", title: "match expressions", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What keyword starts a pattern match in Lean 4?",
                codeSnippet: nil,
                options: ["switch", "case", "match", "when"],
                correctIndex: 2,
                explanation: "Lean 4 uses `match` for pattern matching, similar to `match` in Rust or `case` in Haskell."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the missing keyword.",
                codePrefix: "def isZero (n : Nat) : Bool :=\n  ",
                codeSuffix: " n with\n  | 0 => true\n  | _ => false",
                answer: "match",
                hint: "The keyword for pattern matching in Lean 4."
            )),
            Exercise(kind: .multipleChoice(
                question: "What does `_` mean in a match arm?",
                codeSnippet: "| _ => false",
                options: ["Match nothing", "Match the variable named _", "Match any value (wildcard)", "Match zero"],
                correctIndex: 2,
                explanation: "`_` is a wildcard pattern that matches any value and discards it."
            )),
        ]),

        Lesson(id: "u3l2", title: "Bool and if/then/else", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What does this evaluate to?",
                codeSnippet: "#eval if true then \"yes\" else \"no\"",
                options: ["\"no\"", "\"yes\"", "true", "Error"],
                correctIndex: 1,
                explanation: "`if true then \"yes\" else \"no\"` evaluates the `then` branch and returns `\"yes\"`."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which are valid `Bool`-returning expressions in Lean 4?",
                options: ["1 == 1", "true && false", "\"hello\" == \"hello\"", "5"],
                correctIndices: [0, 1, 2],
                explanation: "`5` alone is a `Nat`, not a `Bool`. The others all produce `Bool` values."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Complete the function to return the larger of two numbers.",
                codePrefix: "def max (a b : Nat) : Nat :=\n  if a > b then a ",
                codeSuffix: " b",
                answer: "else",
                hint: "The `if` must be followed by `then` … `else` …"
            )),
        ]),

        Lesson(id: "u3l3", title: "Recursive Functions", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What keyword allows a definition to call itself in Lean 4?",
                codeSnippet: nil,
                options: ["rec", "loop", "def (the same as always)", "recurse"],
                correctIndex: 2,
                explanation: "In Lean 4, `def` supports structural recursion automatically. No special keyword is needed for terminating recursion."
            )),
            Exercise(kind: .multipleChoice(
                question: "What is the value of `factorial 4` given this definition?",
                codeSnippet: "def factorial : Nat → Nat\n  | 0 => 1\n  | n + 1 => (n + 1) * factorial n",
                options: ["4", "12", "24", "120"],
                correctIndex: 2,
                explanation: "4! = 4 × 3 × 2 × 1 = 24."
            )),
        ]),
    ]
)

// MARK: - Unit 4: Propositions & Proofs

private let unit4 = Unit(
    title: "Propositions & Proofs",
    icon: "checkmark.seal",
    color: "purple",
    lessons: [
        Lesson(id: "u4l1", title: "Propositions as Types", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "In Lean 4, what is a *proposition*?",
                codeSnippet: nil,
                options: [
                    "A function that returns Bool",
                    "A type in the `Prop` universe",
                    "A keyword like `assert`",
                    "A compile-time check",
                ],
                correctIndex: 1,
                explanation: "Lean 4 follows the Curry-Howard correspondence: propositions are types in `Prop`, and proofs are terms of those types."
            )),
            Exercise(kind: .multipleChoice(
                question: "What keyword introduces a theorem in Lean 4?",
                codeSnippet: nil,
                options: ["proof", "def", "theorem", "lemma"],
                correctIndex: 2,
                explanation: "`theorem` (or `lemma`) introduces a statement that must be proved. Under the hood it is a `def` in `Prop`."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the keyword to declare a theorem.",
                codePrefix: "",
                codeSuffix: " hello : True := trivial",
                answer: "theorem",
                hint: "The keyword used to state and prove a mathematical fact."
            )),
        ]),

        Lesson(id: "u4l2", title: "rfl and Equality", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "When can you use `rfl` to close a goal?",
                codeSnippet: "theorem two_plus_two : 2 + 2 = 4 := rfl",
                options: [
                    "When both sides are definitionally equal",
                    "When both sides look identical syntactically",
                    "When the goal is any equality",
                    "Only for natural numbers",
                ],
                correctIndex: 0,
                explanation: "`rfl` proves goals of the form `a = a` where both sides reduce to the same term by computation (definitional equality)."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Prove that addition is reflexive for this specific case.",
                codePrefix: "theorem add_zero_self : 0 + 0 = 0 := ",
                codeSuffix: "",
                answer: "rfl",
                hint: "Both sides reduce to `0` by computation."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which goals can be closed by `rfl`?",
                options: ["2 + 2 = 4", "1 = 2", "\"lean\" = \"lean\"", "true = true"],
                correctIndices: [0, 2, 3],
                explanation: "`1 = 2` is false and cannot be proved. The others are definitionally true."
            )),
        ]),

        Lesson(id: "u4l3", title: "sorry", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What does `sorry` do in a Lean 4 proof?",
                codeSnippet: "theorem hard : 1 = 2 := sorry",
                options: [
                    "Proves the goal rigorously",
                    "Skips the proof with a warning — unsound placeholder",
                    "Raises a compile error",
                    "Asks Lean to search for a proof automatically",
                ],
                correctIndex: 1,
                explanation: "`sorry` is an escape hatch that accepts any goal without proof. Lean emits a warning. It should only be used temporarily while developing."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which statements about `sorry` are true?",
                options: [
                    "It compiles without error",
                    "Lean prints a warning when you use it",
                    "It makes your proof unsound",
                    "It is equivalent to `rfl`",
                ],
                correctIndices: [0, 1, 2],
                explanation: "`sorry` compiles but produces a warning and makes the file axiomatically unsound. It is NOT equivalent to `rfl`."
            )),
        ]),
    ]
)

// MARK: - Unit 5: Tactics

private let unit5 = Unit(
    title: "Tactics",
    icon: "wand.and.stars",
    color: "pink",
    lessons: [
        Lesson(id: "u5l1", title: "intro and exact", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What does the `intro` tactic do?",
                codeSnippet: "-- Goal: ∀ n : Nat, n = n\nintro n\n-- New goal: n = n",
                options: [
                    "Introduces a new hypothesis from the context",
                    "Moves a universal quantifier (∀) or implication (→) into the local context",
                    "Closes the goal if it is an introduction rule",
                    "Imports a namespace",
                ],
                correctIndex: 1,
                explanation: "`intro n` strips the leading `∀ n` or `→` and gives you a local name `n` to work with."
            )),
            Exercise(kind: .multipleChoice(
                question: "What does `exact h` do inside a tactic proof?",
                codeSnippet: nil,
                options: [
                    "Renames the hypothesis h",
                    "Closes the goal using h as the exact proof term",
                    "Searches for a proof named h",
                    "Introduces h into context",
                ],
                correctIndex: 1,
                explanation: "`exact h` closes the current goal if `h` has exactly the right type."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Complete the tactic proof of this trivial implication.",
                codePrefix: "theorem id_proof (h : 1 = 1) : 1 = 1 := by\n  ",
                codeSuffix: " h",
                answer: "exact",
                hint: "Use the tactic that closes a goal with a specific term."
            )),
        ]),

        Lesson(id: "u5l2", title: "apply", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "When you use `apply f` and `f : A → B`, what happens to the goal `B`?",
                codeSnippet: nil,
                options: [
                    "The goal becomes `A → B`",
                    "The goal becomes `A` (you now need to prove the premise)",
                    "The goal is closed",
                    "The goal becomes `f A`",
                ],
                correctIndex: 1,
                explanation: "`apply f` where `f : A → B` reduces goal `B` to goal `A`. You prove the premises one at a time."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Use `apply` to reduce the goal using `Nat.succ_pos`.",
                codePrefix: "theorem pos : 0 < 1 := by\n  ",
                codeSuffix: " Nat.succ_pos 0",
                answer: "exact",
                hint: "`Nat.succ_pos 0 : 0 < 1` directly, so we can use `exact`."
            )),
        ]),

        Lesson(id: "u5l3", title: "simp and ring", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What kind of goals does `simp` help close?",
                codeSnippet: nil,
                options: [
                    "Only arithmetic equalities",
                    "Goals that can be simplified using a library of rewrite rules",
                    "Any goal, automatically",
                    "Only propositional logic goals",
                ],
                correctIndex: 1,
                explanation: "`simp` applies a set of tagged simplification lemmas repeatedly until the goal is closed or can't be simplified further."
            )),
            Exercise(kind: .multipleChoice(
                question: "Which tactic is best for proving polynomial identities over rings?",
                codeSnippet: "-- goal: a * (b + c) = a * b + a * c",
                options: ["rfl", "intro", "ring", "simp"],
                correctIndex: 2,
                explanation: "`ring` is a decision procedure for equalities in commutative (semi)rings. It handles distributivity, commutativity, and associativity automatically."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which of the following can `simp` typically close?",
                options: [
                    "n + 0 = n",
                    "List.append [] l = l",
                    "∀ x, x * x ≥ 0",
                    "a + b = b + a  (for Nat)",
                ],
                correctIndices: [0, 1, 3],
                explanation: "`simp` handles the first three easily using standard lemmas. `∀ x, x * x ≥ 0` usually requires additional reasoning beyond `simp`."
            )),
        ]),
    ]
)
// MARK: - Unit 6: Structures

private let unit6 = Unit(
    title: "Structures",
    icon: "square.3.layers.3d",
    color: "teal",
    lessons: [
        Lesson(id: "u6l1", title: "Defining Structures", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "Which keyword defines a record type with named fields in Lean 4?",
                codeSnippet: nil,
                options: ["record", "struct", "structure", "class"],
                correctIndex: 2,
                explanation: "`structure` defines a product type with named fields and auto-generated projection functions."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the keyword to define a 2D point structure.",
                codePrefix: "",
                codeSuffix: " Point where\n  x : Float\n  y : Float",
                answer: "structure",
                hint: "The keyword for record types in Lean 4."
            )),
            Exercise(kind: .multipleChoice(
                question: "How do you access the `x` field of a `Point` value `p`?",
                codeSnippet: "structure Point where\n  x : Float\n  y : Float",
                options: ["p[x]", "p->x", "p.x", "Point.get p x"],
                correctIndex: 2,
                explanation: "Lean 4 generates a projection `Point.x : Point → Float`. Dot notation `p.x` is syntactic sugar for `Point.x p`."
            )),
        ]),

        Lesson(id: "u6l2", title: "Creating Instances", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "Which syntax creates a `Point` with x = 1.0 and y = 2.0?",
                codeSnippet: "structure Point where\n  x : Float\n  y : Float",
                options: [
                    "Point(1.0, 2.0)",
                    "{ x := 1.0, y := 2.0 }",
                    "Point.mk 1.0 2.0",
                    "Both B and C are valid",
                ],
                correctIndex: 3,
                explanation: "Both anonymous constructor `{ x := 1.0, y := 2.0 }` and the generated `Point.mk 1.0 2.0` are valid. The brace syntax is idiomatic."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which are valid ways to create a `Point` with x = 0.0, y = 0.0?",
                options: [
                    "{ x := 0.0, y := 0.0 }",
                    "Point.mk 0.0 0.0",
                    "⟨0.0, 0.0⟩",
                    "Point 0.0 0.0",
                ],
                correctIndices: [0, 1, 2],
                explanation: "Anonymous constructors `{ }`, `Point.mk`, and angle brackets `⟨⟩` all work. Bare `Point 0.0 0.0` without `.mk` is not valid syntax."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the field accessor to get the `y` coordinate.",
                codePrefix: "def getY (p : Point) : Float := p.",
                codeSuffix: "",
                answer: "y",
                hint: "Dot notation with the field name."
            )),
        ]),

        Lesson(id: "u6l3", title: "Updating & Extending", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "How do you create a copy of `p : Point` with only the `x` field changed to `5.0`?",
                codeSnippet: nil,
                options: [
                    "p.x = 5.0",
                    "{ p with x := 5.0 }",
                    "Point.setX p 5.0",
                    "p.update(x: 5.0)",
                ],
                correctIndex: 1,
                explanation: "The `{ p with x := 5.0 }` syntax creates a new record that copies all fields of `p` except `x`, which is overridden. Structures in Lean 4 are immutable."
            )),
            Exercise(kind: .multipleChoice(
                question: "What does `extends` do in a structure definition?",
                codeSnippet: "structure ColorPoint extends Point where\n  color : String",
                options: [
                    "Creates a subclass like in OOP",
                    "Copies all fields of Point into ColorPoint",
                    "Creates a type alias",
                    "Imports Point's namespace",
                ],
                correctIndex: 1,
                explanation: "`extends` includes all fields of the parent structure. `ColorPoint` gets `x`, `y`, and `color` fields, plus a coercion to `Point`."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Complete the `with` update syntax to move point `p` to y = 0.0.",
                codePrefix: "def resetY (p : Point) : Point := { p ",
                codeSuffix: " y := 0.0 }",
                answer: "with",
                hint: "The keyword between the record and field overrides."
            )),
        ]),
    ]
)

// MARK: - Unit 7: Inductive Types

private let unit7 = Unit(
    title: "Inductive Types",
    icon: "arrow.2.squarepath",
    color: "indigo",
    lessons: [
        Lesson(id: "u7l1", title: "inductive Basics", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What keyword defines a type by listing its constructors?",
                codeSnippet: nil,
                options: ["enum", "union", "inductive", "variant"],
                correctIndex: 2,
                explanation: "`inductive` defines an algebraic data type by giving a name and one or more constructor rules. Both `Bool` and `Nat` are themselves inductive types."
            )),
            Exercise(kind: .multipleChoice(
                question: "How many constructors does this type have?",
                codeSnippet: "inductive Color\n  | red\n  | green\n  | blue",
                options: ["1", "2", "3", "4"],
                correctIndex: 2,
                explanation: "`Color` has exactly 3 constructors: `red`, `green`, and `blue`. Each is a distinct value."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the keyword to define a type with two constructors.",
                codePrefix: "",
                codeSuffix: " Switch | on | off",
                answer: "inductive",
                hint: "The keyword for algebraic data types in Lean 4."
            )),
        ]),

        Lesson(id: "u7l2", title: "Option Type", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What is the type of `Option.some 42`?",
                codeSnippet: nil,
                options: ["Nat", "Option", "Option Nat", "Maybe Nat"],
                correctIndex: 2,
                explanation: "`Option α` is either `none` (no value) or `some a` (a value of type `α`). So `Option.some 42 : Option Nat`."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which are constructors of `Option α`?",
                options: ["none", "some", "nothing", "just"],
                correctIndices: [0, 1],
                explanation: "Lean 4's `Option` has exactly two constructors: `none` and `some`. `nothing` and `just` are Haskell/Scala names."
            )),
            Exercise(kind: .multipleChoice(
                question: "What pattern matches only the `some` case and binds its value?",
                codeSnippet: "match opt with\n  | ??? => …\n  | none => …",
                options: ["| some n => …", "| Option.some n => …", "| just n => …", "Both A and B"],
                correctIndex: 3,
                explanation: "Both `some n` (short form) and `Option.some n` (fully qualified) are valid patterns for the `some` constructor."
            )),
        ]),

        Lesson(id: "u7l3", title: "List Basics", xpReward: 10, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What is `::` in Lean 4?",
                codeSnippet: "#eval 1 :: 2 :: 3 :: []",
                options: [
                    "String concatenation",
                    "The cons constructor — prepends an element to a list",
                    "A type annotation operator",
                    "Namespace access",
                ],
                correctIndex: 1,
                explanation: "`::` is the `List.cons` constructor. `1 :: 2 :: 3 :: []` builds the list `[1, 2, 3]` from right to left."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Fill in the cons operator to prepend 0 to the list.",
                codePrefix: "def myList : List Nat := 0 ",
                codeSuffix: " [1, 2, 3]",
                answer: "::",
                hint: "The cons operator that prepends an element to a list."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which expressions evaluate to the same list `[1, 2]`?",
                options: [
                    "1 :: 2 :: []",
                    "[1, 2]",
                    "1 :: [2]",
                    "List.cons 1 (List.cons 2 List.nil)",
                ],
                correctIndices: [0, 1, 2, 3],
                explanation: "All four are equivalent. Bracket notation, cons chains, and `List.cons/List.nil` are all valid representations of the same list."
            )),
        ]),
    ]
)

// MARK: - Unit 8: More Tactics

private let unit8 = Unit(
    title: "More Tactics",
    icon: "hammer.fill",
    color: "red",
    lessons: [
        Lesson(id: "u8l1", title: "induction Tactic", xpReward: 15, exercises: [
            Exercise(kind: .multipleChoice(
                question: "When should you use the `induction` tactic?",
                codeSnippet: nil,
                options: [
                    "When the goal involves a variable of an inductive type",
                    "When you want to split a conjunction",
                    "When you need to simplify arithmetic",
                    "When the goal is False",
                ],
                correctIndex: 0,
                explanation: "`induction n` on a `Nat` splits into two goals: the base case `n = 0` and the inductive step `n = k+1` (with hypothesis that the property holds for `k`)."
            )),
            Exercise(kind: .multipleChoice(
                question: "After `induction n` on `n : Nat`, how many subgoals appear?",
                codeSnippet: "theorem add_zero : ∀ n : Nat, n + 0 = n := by\n  intro n\n  induction n with\n  | zero => …\n  | succ k ih => …",
                options: ["1", "2", "3", "It depends"],
                correctIndex: 1,
                explanation: "`Nat` has two constructors (`zero` and `succ`), so `induction` produces exactly 2 subgoals: one for each constructor."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Complete the tactic to perform induction on `n`.",
                codePrefix: "theorem zero_add (n : Nat) : 0 + n = n := by\n  ",
                codeSuffix: " n",
                answer: "induction",
                hint: "The tactic that splits a goal by the constructors of an inductive type."
            )),
        ]),

        Lesson(id: "u8l2", title: "omega", xpReward: 15, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What class of goals does the `omega` tactic decide?",
                codeSnippet: nil,
                options: [
                    "All arithmetic goals",
                    "Linear arithmetic over Int and Nat",
                    "Polynomial equalities",
                    "Propositional logic",
                ],
                correctIndex: 1,
                explanation: "`omega` is a decision procedure for linear integer/natural number arithmetic. It handles `+`, `-`, comparisons, and divisibility, but not multiplication of variables."
            )),
            Exercise(kind: .tapAllCorrect(
                question: "Which goals can `omega` close directly?",
                options: [
                    "2 + 2 = 4",
                    "n + 1 > n",
                    "n * n ≥ 0",
                    "¬ (n < n)",
                ],
                correctIndices: [0, 1, 3],
                explanation: "`n * n ≥ 0` involves non-linear multiplication, which `omega` can't handle. The others are linear arithmetic facts."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Use `omega` to close this linear arithmetic goal.",
                codePrefix: "theorem lt_succ (n : Nat) : n < n + 1 := by\n  ",
                codeSuffix: "",
                answer: "omega",
                hint: "The tactic for linear arithmetic over natural numbers and integers."
            )),
        ]),

        Lesson(id: "u8l3", title: "cases and rcases", xpReward: 15, exercises: [
            Exercise(kind: .multipleChoice(
                question: "What does `cases h` do when `h : P ∨ Q`?",
                codeSnippet: nil,
                options: [
                    "Proves P and Q separately",
                    "Splits the goal into two: one assuming P, one assuming Q",
                    "Introduces both P and Q into context",
                    "Eliminates h from the context",
                ],
                correctIndex: 1,
                explanation: "`cases h` on a disjunction `P ∨ Q` splits the proof into two branches: one where you have `h : P` and one where you have `h : Q`."
            )),
            Exercise(kind: .multipleChoice(
                question: "What is `rcases` compared to `cases`?",
                codeSnippet: "-- h : A ∧ B\nrcases h with ⟨ha, hb⟩",
                options: [
                    "A weaker version of cases",
                    "A recursive/deep version that can destructure nested patterns in one step",
                    "Only works on natural numbers",
                    "An alias for `obtain`",
                ],
                correctIndex: 1,
                explanation: "`rcases` (from Mathlib) extends `cases` with richer pattern syntax `⟨_, _⟩` for nested destructuring. `rcases h with ⟨ha, hb⟩` unpacks a conjunction in one step."
            )),
            Exercise(kind: .fillInBlank(
                instruction: "Complete the tactic to split `h : A ∨ B` into two goals.",
                codePrefix: "theorem or_comm (h : A ∨ B) : B ∨ A := by\n  ",
                codeSuffix: " h",
                answer: "cases",
                hint: "The tactic that destructs an inductive hypothesis into its constructors."
            )),
        ]),
    ]
)

// swiftlint:enable line_length
