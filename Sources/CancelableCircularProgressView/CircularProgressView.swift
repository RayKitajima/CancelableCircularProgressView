
import SwiftUI

@available(iOS 13.0.0, *)
struct CircularProgressView: View {
    var value: Double
    var lineWidth: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color

    init(value: Double, lineWidth: CGFloat = 5.0, backgroundColor: Color = .gray, foregroundColor: Color = .accentColor) {
        self.value = value
        self.lineWidth = lineWidth
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(backgroundColor)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.value, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(foregroundColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: value)
                .padding(lineWidth / 2) // Adjust the insets based on the lineWidth
        }
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct CircularProgressView_Previews: PreviewProvider {
    struct PreviewContainer: View {
        let buttonSize: CGFloat = 100
        var body: some View {
            CircularProgressView(value: 0.5, lineWidth: 5)
                .frame(width: buttonSize, height: buttonSize)
        }
    }
    static var previews: some View {
        ForEach(ColorScheme.allCases.reversed(), id: \.self) {
            NavigationView {
                PreviewContainer()
            }
            .preferredColorScheme($0)
        }
    }
}
#endif
