import Foundation

struct UserProgress: Codable {
    var totalXP: Int = 0
    var completedLessonIDs: Set<String> = []
    var currentStreak: Int = 0
    var lastActivityDate: Date?
    var totalLessonsCompleted: Int = 0
    var hearts: Int = 3          // lives within a lesson session

    // MARK: - Streak logic

    mutating func recordActivity(on date: Date = .now) {
        guard let last = lastActivityDate else {
            currentStreak = 1
            lastActivityDate = date
            return
        }

        let calendar = Calendar.current
        let daysSince = calendar.dateComponents([.day], from: last, to: date).day ?? 0

        switch daysSince {
        case 0:
            break             // same day — streak unchanged
        case 1:
            currentStreak += 1
            lastActivityDate = date
        default:
            currentStreak = 1 // gap > 1 day — reset
            lastActivityDate = date
        }
    }

    mutating func completeLesson(id: String, xp: Int, on date: Date = .now) {
        let isNew = completedLessonIDs.insert(id).inserted
        if isNew {
            totalXP += xp
            totalLessonsCompleted += 1
        }
        recordActivity(on: date)
    }

    // MARK: - Persistence

    private static let key = "userProgress"

    func save() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: Self.key)
        }
    }

    static func load() -> UserProgress {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let progress = try? JSONDecoder().decode(UserProgress.self, from: data)
        else { return UserProgress() }
        return progress
    }
}
