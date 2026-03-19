import Foundation
import Combine

@MainActor
final class ProgressViewModel: ObservableObject {
    @Published var progress: UserProgress = .load()

    func completeLesson(id: String, xp: Int) {
        progress.completeLesson(id: id, xp: xp)
        progress.save()
    }

    func isLessonCompleted(_ id: String) -> Bool {
        progress.completedLessonIDs.contains(id)
    }

    // Reset hearts for a new lesson attempt
    func resetHearts() {
        progress.hearts = 3
        progress.save()
    }

    func loseHeart() {
        progress.hearts = max(0, progress.hearts - 1)
        progress.save()
    }
}
