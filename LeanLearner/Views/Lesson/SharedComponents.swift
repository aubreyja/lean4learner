import SwiftUI

// MARK: - Option button

enum OptionState { case idle, selected, correct, wrong }

struct OptionButton: View {
    let text: String
    let state: OptionState
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.vertical, 12)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)
                .background(background)
                .foregroundColor(foreground)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(border, lineWidth: 2)
                )
        }
    }

    private var background: Color {
        switch state {
        case .idle:     return Color(.secondarySystemBackground)
        case .selected: return Color.purple.opacity(0.15)
        case .correct:  return Color.green.opacity(0.15)
        case .wrong:    return Color.red.opacity(0.15)
        }
    }

    private var border: Color {
        switch state {
        case .idle:     return Color.clear
        case .selected: return Color.purple
        case .correct:  return Color.green
        case .wrong:    return Color.red
        }
    }

    private var foreground: Color {
        switch state {
        case .correct:  return .green
        case .wrong:    return .red
        default:        return .primary
        }
    }
}

// MARK: - Feedback banner

struct FeedbackBanner: View {
    let correct: Bool
    let explanation: String
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            VStack(alignment: .leading, spacing: 10) {
                Label(
                    correct ? "Correct!" : "Incorrect",
                    systemImage: correct ? "checkmark.circle.fill" : "xmark.circle.fill"
                )
                .font(.headline)
                .foregroundColor(correct ? .green : .red)

                Text(explanation)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Button("Continue", action: onContinue)
                    .buttonStyle(PrimaryButtonStyle(color: correct ? .green : .red))
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
}

// MARK: - Code block

struct CodeBlockView: View {
    let code: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(code)
                .font(.system(.body, design: .monospaced))
                .padding(12)
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

// MARK: - Button style

struct PrimaryButtonStyle: ButtonStyle {
    var color: Color = .purple

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(.white)
            .cornerRadius(14)
    }
}
