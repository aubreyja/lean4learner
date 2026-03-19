import SwiftUI

struct LessonCompleteView: View {
    let xpEarned: Int
    let lessonTitle: String
    let onDone: () -> Void

    @State private var appeared = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .scaleEffect(appeared ? 1 : 0.3)
                .opacity(appeared ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: appeared)

            Text("Lesson Complete!")
                .font(.largeTitle).bold()

            Text(lessonTitle)
                .font(.title3)
                .foregroundColor(.secondary)

            HStack(spacing: 8) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("+\(xpEarned) XP")
                    .font(.title2).bold()
            }

            Spacer()

            Button("Continue", action: onDone)
                .buttonStyle(PrimaryButtonStyle())
                .padding()
        }
        .onAppear { appeared = true }
    }
}
