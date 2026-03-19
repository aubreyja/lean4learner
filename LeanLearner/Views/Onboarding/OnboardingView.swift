import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var page = 0

    private let pages: [(icon: String, title: String, body: String)] = [
        ("function",
         "Learn Lean 4",
         "Master the Lean 4 proof assistant through bite-sized interactive lessons — from first expressions to full tactic proofs."),
        ("checkmark.seal.fill",
         "Prove Theorems",
         "Write real Lean 4 proofs. Learn tactics like `rfl`, `simp`, `intro`, and `apply` step by step."),
        ("flame.fill",
         "Build a Streak",
         "Stay consistent. Practice daily to keep your streak alive and earn XP as you progress through the curriculum."),
    ]

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $page) {
                ForEach(pages.indices, id: \.self) { i in
                    OnboardingPageView(
                        icon: pages[i].icon,
                        title: pages[i].title,
                        body: pages[i].body
                    )
                    .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            Button(action: {
                if page < pages.count - 1 {
                    withAnimation { page += 1 }
                } else {
                    hasCompletedOnboarding = true
                }
            }) {
                Text(page < pages.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 24)
            }
            .padding(.bottom, 40)
        }
        .background(Color(.systemBackground))
    }
}

private struct OnboardingPageView: View {
    let icon: String
    let title: String
    let body: String

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.purple)
            Text(title)
                .font(.largeTitle).bold()
                .multilineTextAlignment(.center)
            Text(body)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
        }
    }
}
