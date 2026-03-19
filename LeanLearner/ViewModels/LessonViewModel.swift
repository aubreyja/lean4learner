import Foundation
import Combine

@MainActor
final class LessonViewModel: ObservableObject {
    let lesson: Lesson
    private weak var progressVM: ProgressViewModel?

    @Published var currentIndex: Int = 0
    @Published var showFeedback: Bool = false
    @Published var lastAnswerCorrect: Bool = false
    @Published var isComplete: Bool = false
    @Published var xpEarned: Int = 0

    private var perfectLesson = true

    var currentExercise: Exercise? {
        guard currentIndex < lesson.exercises.count else { return nil }
        return lesson.exercises[currentIndex]
    }

    var progress: Double {
        Double(currentIndex) / Double(lesson.exercises.count)
    }

    init(lesson: Lesson, progressVM: ProgressViewModel) {
        self.lesson = lesson
        self.progressVM = progressVM
    }

    func submit(correct: Bool) {
        lastAnswerCorrect = correct
        showFeedback = true
        if !correct {
            perfectLesson = false
            progressVM?.loseHeart()
        }
    }

    func advance() {
        showFeedback = false
        if currentIndex + 1 >= lesson.exercises.count {
            finishLesson()
        } else {
            currentIndex += 1
        }
    }

    private func finishLesson() {
        let bonus = perfectLesson ? 50 : 0
        xpEarned = lesson.xpReward + bonus
        progressVM?.completeLesson(id: lesson.id, xp: xpEarned)
        isComplete = true
    }
}
