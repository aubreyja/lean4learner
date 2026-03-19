import SwiftUI

struct HomeView: View {
    @EnvironmentObject var progressVM: ProgressViewModel
    let course = LessonContent.course

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Streak + XP header
                    HStack(spacing: 24) {
                        Label("\(progressVM.progress.currentStreak)", systemImage: "flame.fill")
                            .foregroundColor(.orange)
                        Spacer()
                        Label("\(progressVM.progress.totalXP) XP", systemImage: "star.fill")
                            .foregroundColor(.yellow)
                        Spacer()
                        Label("\(progressVM.progress.hearts)", systemImage: "heart.fill")
                            .foregroundColor(.red)
                    }
                    .font(.headline)
                    .padding()
                    .background(Color(.secondarySystemBackground))

                    ForEach(course.units) { unit in
                        UnitSectionView(unit: unit)
                    }
                }
            }
            .navigationTitle("Learn Lean 4")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
