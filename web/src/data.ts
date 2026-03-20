import type { Course, Exercise } from './types'

function mc(
  question: string,
  codeSnippet: string | undefined,
  options: string[],
  correctIndex: number,
  explanation: string,
): Exercise {
  return {
    id: Math.random().toString(36).slice(2),
    kind: { type: 'multipleChoice', question, codeSnippet, options, correctIndex, explanation },
  }
}

function fib(
  instruction: string,
  codePrefix: string,
  codeSuffix: string,
  answer: string,
  hint: string,
): Exercise {
  return {
    id: Math.random().toString(36).slice(2),
    kind: { type: 'fillInBlank', instruction, codePrefix, codeSuffix, answer, hint },
  }
}

function tac(
  question: string,
  options: string[],
  correctIndices: number[],
  explanation: string,
): Exercise {
  return {
    id: Math.random().toString(36).slice(2),
    kind: { type: 'tapAllCorrect', question, options, correctIndices, explanation },
  }
}

export const course: Course = {
  title: 'Learn Lean 4',
  tagline: 'From zero to proofs, one lesson at a time.',
  units: [
    {
      id: 'u1',
      title: 'Expressions & Types',
      emoji: '🔢',
      colorClass: 'from-blue-600 to-blue-800',
      lessons: [
        {
          id: 'u1l1',
          title: '#eval and #check',
          xpReward: 10,
          exercises: [
            mc(
              'What does `#eval` do in Lean 4?',
              '#eval 2 + 3',
              [
                'Declares a function',
                'Evaluates an expression and prints the result',
                'Checks the type of an expression',
                'Imports a library',
              ],
              1,
              '`#eval` evaluates an expression and shows its value in the infoview. Here it prints `5`.',
            ),
            mc(
              'What does `#check` show you?',
              '#check 42',
              [
                'The value of the expression',
                'The type of the expression',
                'Whether the expression is a theorem',
                'The memory usage',
              ],
              1,
              '`#check 42` shows `42 : Nat` — the expression and its inferred type.',
            ),
            fib(
              'Fill in the command to evaluate the string "Hello, Lean!"',
              '',
              ' "Hello, Lean!"',
              '#eval',
              'Use the command that evaluates and prints an expression.',
            ),
          ],
        },
        {
          id: 'u1l2',
          title: 'Basic Types',
          xpReward: 10,
          exercises: [
            mc(
              'Which type represents non-negative whole numbers in Lean 4?',
              undefined,
              ['Int', 'Float', 'Nat', 'UInt32'],
              2,
              '`Nat` is the type of natural numbers (0, 1, 2, …). `Int` allows negatives.',
            ),
            tac(
              'Which of the following are valid Lean 4 expressions of type `Bool`?',
              ['true', 'false', '1', '"yes"'],
              [0, 1],
              '`true` and `false` are the two values of type `Bool`. `1` is `Nat` and `"yes"` is `String`.',
            ),
            fib(
              'What type annotation completes this to declare x as a natural number?',
              'def x : ',
              ' := 7',
              'Nat',
              'The type of 0, 1, 2, 3, … in Lean 4.',
            ),
          ],
        },
        {
          id: 'u1l3',
          title: 'Arithmetic',
          xpReward: 10,
          exercises: [
            mc(
              'What does this expression evaluate to?',
              '#eval 10 - 3',
              ['7', '-3', '13', 'Error'],
              0,
              'Subtraction on `Nat` is defined. `10 - 3 = 7`.',
            ),
            mc(
              'What is `3 - 5` when both operands are `Nat`?',
              '#eval (3 : Nat) - 5',
              ['-2', '0', '2', 'Error'],
              1,
              '`Nat` subtraction is *truncated*: `3 - 5 = 0` because natural numbers can\'t be negative.',
            ),
            fib(
              'Complete the expression to compute 2 to the power of 8.',
              '#eval 2 ^ ',
              '',
              '8',
              'The exponent goes after `^`.',
            ),
          ],
        },
      ],
    },
    {
      id: 'u2',
      title: 'Functions',
      emoji: 'ƒ',
      colorClass: 'from-green-600 to-green-800',
      lessons: [
        {
          id: 'u2l1',
          title: 'def and fun',
          xpReward: 10,
          exercises: [
            mc(
              'Which keyword defines a named function in Lean 4?',
              undefined,
              ['fn', 'func', 'def', 'fun'],
              2,
              '`def` defines a named declaration. `fun` creates an anonymous function (lambda).',
            ),
            fib(
              'Fill in the keyword to define a named function `double`.',
              '',
              ' double (n : Nat) : Nat := n * 2',
              'def',
              'The keyword for named definitions in Lean 4.',
            ),
            mc(
              'What does this anonymous function do?',
              'fun x => x + 1',
              ['Multiplies x by itself', 'Returns x unchanged', 'Adds 1 to x', 'Subtracts 1 from x'],
              2,
              '`fun x => x + 1` is a lambda that takes `x` and returns `x + 1`.',
            ),
          ],
        },
        {
          id: 'u2l2',
          title: 'Arrow Types',
          xpReward: 10,
          exercises: [
            mc(
              'What is the type of a function from `Nat` to `Bool`?',
              undefined,
              ['Bool → Nat', 'Nat → Bool', 'Nat : Bool', 'Bool Nat'],
              1,
              'Function types use `→`. `Nat → Bool` is a function taking a `Nat` and returning a `Bool`.',
            ),
            fib(
              'Complete the type signature for a function that takes two `Nat`s and returns a `Nat`.',
              'def add (a b : Nat) : ',
              ' := a + b',
              'Nat',
              'The return type goes after the colon.',
            ),
            tac(
              'Which of the following are valid function type expressions in Lean 4?',
              ['Nat → Nat', 'String → Bool', 'Int → Int → Int', '42 → Nat'],
              [0, 1, 2],
              '`42 → Nat` is invalid because `42` is a value, not a type. The others are valid function types.',
            ),
          ],
        },
        {
          id: 'u2l3',
          title: 'Currying',
          xpReward: 10,
          exercises: [
            mc(
              'In Lean 4, a function of two arguments is really…',
              'def add (a : Nat) (b : Nat) : Nat := a + b',
              [
                'A tuple-taking function',
                'A function returning another function',
                'A special two-argument construct',
                'Invalid — use tuples instead',
              ],
              1,
              'Lean 4 uses currying. `add` has type `Nat → Nat → Nat`: it takes one `Nat` and returns a function `Nat → Nat`.',
            ),
            mc(
              'What does `add 3` evaluate to if `add : Nat → Nat → Nat`?',
              undefined,
              ['3', 'A function Nat → Nat', 'An error', '0'],
              1,
              'Partial application! `add 3` returns a new function that adds 3 to its argument.',
            ),
          ],
        },
      ],
    },
    {
      id: 'u3',
      title: 'Pattern Matching',
      emoji: '🌿',
      colorClass: 'from-orange-500 to-orange-700',
      lessons: [
        {
          id: 'u3l1',
          title: 'match expressions',
          xpReward: 10,
          exercises: [
            mc(
              'What keyword starts a pattern match in Lean 4?',
              undefined,
              ['switch', 'case', 'match', 'when'],
              2,
              'Lean 4 uses `match` for pattern matching, similar to `match` in Rust or `case` in Haskell.',
            ),
            fib(
              'Fill in the missing keyword.',
              'def isZero (n : Nat) : Bool :=\n  ',
              ' n with\n  | 0 => true\n  | _ => false',
              'match',
              'The keyword for pattern matching in Lean 4.',
            ),
            mc(
              'What does `_` mean in a match arm?',
              '| _ => false',
              ['Match nothing', 'Match the variable named _', 'Match any value (wildcard)', 'Match zero'],
              2,
              '`_` is a wildcard pattern that matches any value and discards it.',
            ),
          ],
        },
        {
          id: 'u3l2',
          title: 'Bool and if/then/else',
          xpReward: 10,
          exercises: [
            mc(
              'What does this evaluate to?',
              '#eval if true then "yes" else "no"',
              ['"no"', '"yes"', 'true', 'Error'],
              1,
              '`if true then "yes" else "no"` evaluates the `then` branch and returns `"yes"`.',
            ),
            tac(
              'Which are valid `Bool`-returning expressions in Lean 4?',
              ['1 == 1', 'true && false', '"hello" == "hello"', '5'],
              [0, 1, 2],
              '`5` alone is a `Nat`, not a `Bool`. The others all produce `Bool` values.',
            ),
            fib(
              'Complete the function to return the larger of two numbers.',
              'def max (a b : Nat) : Nat :=\n  if a > b then a ',
              ' b',
              'else',
              'The `if` must be followed by `then` … `else` …',
            ),
          ],
        },
        {
          id: 'u3l3',
          title: 'Recursive Functions',
          xpReward: 10,
          exercises: [
            mc(
              'What keyword allows a definition to call itself in Lean 4?',
              undefined,
              ['rec', 'loop', 'def (the same as always)', 'recurse'],
              2,
              'In Lean 4, `def` supports structural recursion automatically. No special keyword is needed for terminating recursion.',
            ),
            mc(
              'What is the value of `factorial 4` given this definition?',
              'def factorial : Nat → Nat\n  | 0 => 1\n  | n + 1 => (n + 1) * factorial n',
              ['4', '12', '24', '120'],
              2,
              '4! = 4 × 3 × 2 × 1 = 24.',
            ),
          ],
        },
      ],
    },
    {
      id: 'u4',
      title: 'Propositions & Proofs',
      emoji: '✅',
      colorClass: 'from-violet-600 to-violet-800',
      lessons: [
        {
          id: 'u4l1',
          title: 'Propositions as Types',
          xpReward: 10,
          exercises: [
            mc(
              'In Lean 4, what is a *proposition*?',
              undefined,
              [
                'A function that returns Bool',
                'A type in the `Prop` universe',
                'A keyword like `assert`',
                'A compile-time check',
              ],
              1,
              'Lean 4 follows the Curry-Howard correspondence: propositions are types in `Prop`, and proofs are terms of those types.',
            ),
            mc(
              'What keyword introduces a theorem in Lean 4?',
              undefined,
              ['proof', 'def', 'theorem', 'lemma'],
              2,
              '`theorem` (or `lemma`) introduces a statement that must be proved. Under the hood it is a `def` in `Prop`.',
            ),
            fib(
              'Fill in the keyword to declare a theorem.',
              '',
              ' hello : True := trivial',
              'theorem',
              'The keyword used to state and prove a mathematical fact.',
            ),
          ],
        },
        {
          id: 'u4l2',
          title: 'rfl and Equality',
          xpReward: 10,
          exercises: [
            mc(
              'When can you use `rfl` to close a goal?',
              'theorem two_plus_two : 2 + 2 = 4 := rfl',
              [
                'When both sides are definitionally equal',
                'When both sides look identical syntactically',
                'When the goal is any equality',
                'Only for natural numbers',
              ],
              0,
              '`rfl` proves goals of the form `a = a` where both sides reduce to the same term by computation (definitional equality).',
            ),
            fib(
              'Prove that addition is reflexive for this specific case.',
              'theorem add_zero_self : 0 + 0 = 0 := ',
              '',
              'rfl',
              'Both sides reduce to `0` by computation.',
            ),
            tac(
              'Which goals can be closed by `rfl`?',
              ['2 + 2 = 4', '1 = 2', '"lean" = "lean"', 'true = true'],
              [0, 2, 3],
              '`1 = 2` is false and cannot be proved. The others are definitionally true.',
            ),
          ],
        },
        {
          id: 'u4l3',
          title: 'sorry',
          xpReward: 10,
          exercises: [
            mc(
              'What does `sorry` do in a Lean 4 proof?',
              'theorem hard : 1 = 2 := sorry',
              [
                'Proves the goal rigorously',
                'Skips the proof with a warning — unsound placeholder',
                'Raises a compile error',
                'Asks Lean to search for a proof automatically',
              ],
              1,
              '`sorry` is an escape hatch that accepts any goal without proof. Lean emits a warning. It should only be used temporarily while developing.',
            ),
            tac(
              'Which statements about `sorry` are true?',
              [
                'It compiles without error',
                'Lean prints a warning when you use it',
                'It makes your proof unsound',
                'It is equivalent to `rfl`',
              ],
              [0, 1, 2],
              '`sorry` compiles but produces a warning and makes the file axiomatically unsound. It is NOT equivalent to `rfl`.',
            ),
          ],
        },
      ],
    },
    {
      id: 'u5',
      title: 'Tactics',
      emoji: '✨',
      colorClass: 'from-pink-500 to-pink-700',
      lessons: [
        {
          id: 'u5l1',
          title: 'intro and exact',
          xpReward: 10,
          exercises: [
            mc(
              'What does the `intro` tactic do?',
              '-- Goal: ∀ n : Nat, n = n\nintro n\n-- New goal: n = n',
              [
                'Introduces a new hypothesis from the context',
                'Moves a universal quantifier (∀) or implication (→) into the local context',
                'Closes the goal if it is an introduction rule',
                'Imports a namespace',
              ],
              1,
              '`intro n` strips the leading `∀ n` or `→` and gives you a local name `n` to work with.',
            ),
            mc(
              'What does `exact h` do inside a tactic proof?',
              undefined,
              [
                'Renames the hypothesis h',
                'Closes the goal using h as the exact proof term',
                'Searches for a proof named h',
                'Introduces h into context',
              ],
              1,
              '`exact h` closes the current goal if `h` has exactly the right type.',
            ),
            fib(
              'Complete the tactic proof of this trivial implication.',
              'theorem id_proof (h : 1 = 1) : 1 = 1 := by\n  ',
              ' h',
              'exact',
              'Use the tactic that closes a goal with a specific term.',
            ),
          ],
        },
        {
          id: 'u5l2',
          title: 'apply',
          xpReward: 10,
          exercises: [
            mc(
              'When you use `apply f` and `f : A → B`, what happens to the goal `B`?',
              undefined,
              [
                'The goal becomes `A → B`',
                'The goal becomes `A` (you now need to prove the premise)',
                'The goal is closed',
                'The goal becomes `f A`',
              ],
              1,
              '`apply f` where `f : A → B` reduces goal `B` to goal `A`. You prove the premises one at a time.',
            ),
            fib(
              'Use `exact` to close the goal using `Nat.succ_pos`.',
              'theorem pos : 0 < 1 := by\n  ',
              ' Nat.succ_pos 0',
              'exact',
              '`Nat.succ_pos 0 : 0 < 1` directly, so we can use `exact`.',
            ),
          ],
        },
        {
          id: 'u5l3',
          title: 'simp and ring',
          xpReward: 10,
          exercises: [
            mc(
              'What kind of goals does `simp` help close?',
              undefined,
              [
                'Only arithmetic equalities',
                'Goals that can be simplified using a library of rewrite rules',
                'Any goal, automatically',
                'Only propositional logic goals',
              ],
              1,
              '`simp` applies a set of tagged simplification lemmas repeatedly until the goal is closed or can\'t be simplified further.',
            ),
            mc(
              'Which tactic is best for proving polynomial identities over rings?',
              '-- goal: a * (b + c) = a * b + a * c',
              ['rfl', 'intro', 'ring', 'simp'],
              2,
              '`ring` is a decision procedure for equalities in commutative (semi)rings. It handles distributivity, commutativity, and associativity automatically.',
            ),
            tac(
              'Which of the following can `simp` typically close?',
              ['n + 0 = n', 'List.append [] l = l', '∀ x, x * x ≥ 0', 'a + b = b + a  (for Nat)'],
              [0, 1, 3],
              '`simp` handles the first three easily using standard lemmas. `∀ x, x * x ≥ 0` usually requires additional reasoning beyond `simp`.',
            ),
          ],
        },
      ],
    },
  ],
}

/** Flat ordered list of all lessons across all units. */
export const allLessons = course.units.flatMap((u) => u.lessons)

/** Returns true if the lesson at flatIndex is unlocked given completedIDs. */
export function isUnlocked(flatIndex: number, completedIDs: Set<string>): boolean {
  if (flatIndex === 0) return true
  return completedIDs.has(allLessons[flatIndex - 1].id)
}
