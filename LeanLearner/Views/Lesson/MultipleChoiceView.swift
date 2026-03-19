import SwiftUI

struct MultipleChoiceView: View {
    let question: String
    let codeSnippet: String?
    let options: [String]
    let correctIndex: Int
    let explanation: String
    @ObservedObject var vm: LessonViewModel

    @State private var selectedIndex: Int? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question)
                .font(.title3).bold()
                .padding(.horizontal)

            if let snippet = codeSnippet {
                CodeBlockView(code: snippet)
                    .padding(.horizontal)
            }

            VStack(spacing: 10) {
                ForEach(options.indices, id: \.self) { i in
                    OptionButton(
                        text: options[i],
                        state: buttonState(for: i)
                    ) {
                        guard !vm.showFeedback else { return }
                        selectedIndex = i
                    }
                    .padding(.horizontal)
                }
            }

            Spacer()

            if vm.showFeedback {
                FeedbackBanner(correct: vm.lastAnswerCorrect, explanation: explanation) {
                    selectedIndex = nil
                    vm.advance()
                }
            } else {
                Button("Check") {
                    guard let sel = selectedIndex else { return }
                    vm.submit(correct: sel == correctIndex)
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(selectedIndex == nil)
                .padding()
            }
        }
        .padding(.top)
    }

    private func buttonState(for index: Int) -> OptionState {
        guard let sel = selectedIndex else { return .idle }
        if !vm.showFeedback { return index == sel ? .selected : .idle }
        if index == correctIndex { return .correct }
        if index == sel { return .wrong }
        return .idle
    }
}
