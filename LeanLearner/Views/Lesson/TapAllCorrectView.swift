import SwiftUI

struct TapAllCorrectView: View {
    let question: String
    let options: [String]
    let correctIndices: Set<Int>
    let explanation: String
    @ObservedObject var vm: LessonViewModel

    @State private var selected: Set<Int> = []

    private var isCorrect: Bool { selected == correctIndices }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question)
                .font(.title3).bold()
                .padding(.horizontal)

            Text("Select ALL that apply.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(options.indices, id: \.self) { i in
                    OptionButton(
                        text: options[i],
                        state: chipState(for: i)
                    ) {
                        guard !vm.showFeedback else { return }
                        if selected.contains(i) {
                            selected.remove(i)
                        } else {
                            selected.insert(i)
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            if vm.showFeedback {
                FeedbackBanner(correct: vm.lastAnswerCorrect, explanation: explanation) {
                    selected = []
                    vm.advance()
                }
            } else {
                Button("Check") {
                    vm.submit(correct: isCorrect)
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(selected.isEmpty)
                .padding()
            }
        }
        .padding(.top)
    }

    private func chipState(for index: Int) -> OptionState {
        if !vm.showFeedback {
            return selected.contains(index) ? .selected : .idle
        }
        if correctIndices.contains(index) { return .correct }
        if selected.contains(index) { return .wrong }
        return .idle
    }
}
