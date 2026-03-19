import SwiftUI

@main
struct LeanLearnerApp: App {
    @StateObject private var progressVM = ProgressViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(progressVM)
        }
    }
}
