import Foundation

struct Exercise: Identifiable {
    let id = UUID()
    let kind: ExerciseKind
}

enum ExerciseKind {
    /// Show a question (optionally with a code block) and pick the right option.
    case multipleChoice(
        question: String,
        codeSnippet: String?,
        options: [String],
        correctIndex: Int,
        explanation: String
    )

    /// Complete the missing part of a Lean snippet.
    case fillInBlank(
        instruction: String,
        codePrefix: String,
        codeSuffix: String,
        answer: String,
        hint: String
    )

    /// Given a description, tap ALL correct options (may be more than one).
    case tapAllCorrect(
        question: String,
        options: [String],
        correctIndices: Set<Int>,
        explanation: String
    )
}
