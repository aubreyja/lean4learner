import Foundation

struct Course: Identifiable {
    let id = UUID()
    let title: String
    let tagline: String
    let units: [Unit]
}

struct Unit: Identifiable {
    let id = UUID()
    let title: String
    let icon: String          // SF Symbol name
    let color: String         // hex or named color key
    let lessons: [Lesson]
}

struct Lesson: Identifiable {
    let id: String            // stable string ID for persistence
    let title: String
    let xpReward: Int
    let exercises: [Exercise]
}
