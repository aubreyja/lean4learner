import SwiftUI

struct FillInBlankView: View {
    let instruction: String
    let codePrefix: String
    let codeSuffix: String
    let answer: String
    let hint: String
    @ObservedObject var vm: LessonViewModel

    @State private var userInput = ""
    @State private var showHint = false
    @FocusState private var inputFocused: Bool

    private var isCorrect: Bool {
        userInput.trimmingCharacters(in: .whitespaces) == answer
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(instruction)
                .font(.title3).bold()
                .padding(.horizontal)

            // Code with inline text field
            VStack(alignment: .leading, spacing: 0) {
                Text(codePrefix)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.primary)
                    .padding(.top, 12)
                    .padding(.horizontal, 12)

                TextField("type your answer…", text: $userInput)
                    .font(.system(.body, design: .monospaced))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($inputFocused)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(6)
                    .padding(.horizontal, 12)

                Text(codeSuffix)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.primary)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 12)
            }
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .padding(.horizontal)

            if showHint {
                Label(hint, systemImage: "lightbulb.fill")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.horizontal)
            } else {
                Button("Show hint") { showHint = true }
                    .font(.caption)
                    .foregroundColor(.purple)
                    .padding(.horizontal)
            }

            Spacer()

            if vm.showFeedback {
                FeedbackBanner(correct: vm.lastAnswerCorrect, explanation: "Correct answer: \(answer)") {
                    userInput = ""
                    showHint = false
                    vm.advance()
                }
            } else {
                Button("Check") {
                    inputFocused = false
                    vm.submit(correct: isCorrect)
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(userInput.trimmingCharacters(in: .whitespaces).isEmpty)
                .padding()
            }
        }
        .padding(.top)
        .onAppear { inputFocused = true }
    }
}
