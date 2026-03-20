import SwiftUI

struct UserProgressView: View {
    @EnvironmentObject var progressVM: ProgressViewModel

    var body: some View {
        NavigationStack {
            List {
                Section {
                    StatRow(icon: "flame.fill", color: .orange,
                            label: "Current Streak",
                            value: "\(progressVM.progress.currentStreak) days")
                    StatRow(icon: "star.fill", color: .yellow,
                            label: "Total XP",
                            value: "\(progressVM.progress.totalXP)")
                    StatRow(icon: "checkmark.circle.fill", color: .green,
                            label: "Lessons Completed",
                            value: "\(progressVM.progress.totalLessonsCompleted)")
                    StatRow(icon: "heart.fill", color: .red,
                            label: "Hearts",
                            value: "\(progressVM.progress.hearts) / 3")
                } header: {
                    Text("Your Stats")
                }

                Section {
                    if let last = progressVM.progress.lastActivityDate {
                        StatRow(icon: "calendar", color: .purple,
                                label: "Last Active",
                                value: last.formatted(date: .abbreviated, time: .omitted))
                    } else {
                        Text("No activity recorded yet.")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Activity")
                }
            }
            .navigationTitle("Progress")
        }
    }
}

private struct StatRow: View {
    let icon: String
    let color: Color
    let label: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 28)
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .bold()
        }
    }
}
