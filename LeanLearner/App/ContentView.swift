import SwiftUI

struct RootView: View {
    @EnvironmentObject var progressVM: ProgressViewModel
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingView()
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }

            UserProgressView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
        }
        .accentColor(.purple)
    }
}
