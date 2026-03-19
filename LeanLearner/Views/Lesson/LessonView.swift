import SwiftUI

/// Wraps LessonView and owns the LessonViewModel.
struct LessonContainerView: View {
    let lesson: Lesson
    @EnvironmentObject var progressVM: ProgressViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LessonView(
            vm: LessonViewModel(lesson: lesson, progressVM: progressVM)
        )
    }
}

struct LessonView: View {
    @StateObject var vm: LessonViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            if vm.isComplete {
                LessonCompleteView(xpEarned: vm.xpEarned, lessonTitle: vm.lesson.title) {
                    dismiss()
                }
            } else {
                VStack(spacing: 0) {
                    // Top bar: close + progress
                    HStack(spacing: 12) {
                        Button { dismiss() } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }

                        ProgressView(value: vm.progress)
                            .tint(.purple)

                        Text("\(Int(vm.progress * 100))%")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()

                    if let exercise = vm.currentExercise {
                        ExerciseDispatchView(exercise: exercise, vm: vm)
                    }
                }
            }
        }
        .background(Color(.systemBackground))
    }
}
