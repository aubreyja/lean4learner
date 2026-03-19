import SwiftUI

struct UnitSectionView: View {
    let unit: Unit
    @EnvironmentObject var progressVM: ProgressViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Unit header
            HStack {
                Image(systemName: unit.icon)
                    .font(.title2)
                Text(unit.title)
                    .font(.title2).bold()
                Spacer()
            }
            .padding()
            .background(unitColor(unit.color).opacity(0.15))
            .foregroundColor(unitColor(unit.color))

            // Lesson cells
            ForEach(Array(unit.lessons.enumerated()), id: \.element.id) { index, lesson in
                LessonRowView(lesson: lesson, unit: unit, index: index)
            }
        }
        .padding(.bottom, 8)
    }

    private func unitColor(_ name: String) -> Color {
        switch name {
        case "blue":    return .blue
        case "green":   return .green
        case "orange":  return .orange
        case "purple":  return .purple
        case "pink":    return .pink
        default:        return .purple
        }
    }
}

struct LessonRowView: View {
    let lesson: Lesson
    let unit: Unit
    let index: Int

    @EnvironmentObject var progressVM: ProgressViewModel
    @State private var showLesson = false

    var isCompleted: Bool { progressVM.isLessonCompleted(lesson.id) }

    var body: some View {
        Button {
            showLesson = true
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(isCompleted ? Color.green : Color(.secondarySystemBackground))
                        .frame(width: 48, height: 48)
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.headline)
                    } else {
                        Text("\(index + 1)")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(lesson.title)
                        .font(.body).bold()
                        .foregroundColor(.primary)
                    Text("\(lesson.xpReward) XP")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .fullScreenCover(isPresented: $showLesson) {
            LessonContainerView(lesson: lesson)
        }

        Divider().padding(.leading, 76)
    }
}
