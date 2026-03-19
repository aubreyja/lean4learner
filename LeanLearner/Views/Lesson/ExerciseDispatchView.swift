import SwiftUI

/// Routes to the correct exercise view based on ExerciseKind.
struct ExerciseDispatchView: View {
    let exercise: Exercise
    @ObservedObject var vm: LessonViewModel

    var body: some View {
        switch exercise.kind {
        case let .multipleChoice(question, snippet, options, correct, explanation):
            MultipleChoiceView(
                question: question,
                codeSnippet: snippet,
                options: options,
                correctIndex: correct,
                explanation: explanation,
                vm: vm
            )
        case let .fillInBlank(instruction, prefix, suffix, answer, hint):
            FillInBlankView(
                instruction: instruction,
                codePrefix: prefix,
                codeSuffix: suffix,
                answer: answer,
                hint: hint,
                vm: vm
            )
        case let .tapAllCorrect(question, options, correctIndices, explanation):
            TapAllCorrectView(
                question: question,
                options: options,
                correctIndices: correctIndices,
                explanation: explanation,
                vm: vm
            )
        }
    }
}
