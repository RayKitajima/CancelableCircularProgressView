
import SwiftUI

@available(iOS 13.0.0, *)
struct CancelableCircularProgressView: View {
    var value: Double
    var lineWidth: CGFloat
    var iconSize: CGFloat
    var backgroundColor: Color = .gray
    var foregroundColor: Color = .accentColor

    init(value: Double, lineWidth: CGFloat = 5.0, iconSize: CGFloat = 32, backgroundColor: Color = .gray, foregroundColor: Color = .accentColor) {
        self.value = value
        self.lineWidth = lineWidth
        self.iconSize = iconSize
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    var body: some View {
        ZStack {
            CircularProgressView(value: value, lineWidth: lineWidth, backgroundColor: backgroundColor, foregroundColor: foregroundColor)
                .frame(width: iconSize, height: iconSize)
            Image(systemName: "stop.fill")
                .resizable()
                .foregroundColor(backgroundColor)
                .frame(width: iconSize * 0.40, height: iconSize * 0.40)
        }
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct CancelableCircularProgressView_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var showProgress: Bool = false
        @State private var playbackProgress: Double = 0.0
        @State private var timer: Timer? = nil
        @State private var isPaused: Bool = false

        let buttonSize: CGFloat = 100

        var body: some View {
            VStack(spacing: 20) {
                if showProgress {
                    CancelableCircularProgressView(
                        value: playbackProgress,
                        lineWidth: 8,
                        iconSize: buttonSize,
                        backgroundColor: .yellow,
                        foregroundColor: .pink
                    )
                    .frame(width: buttonSize, height: buttonSize)
                    .onTapGesture { stopPlayback() }
                } else {
                    Button(action: startPlayback) {
                        Image(systemName: "play.circle")
                            .resizable()
                            .frame(width: buttonSize, height: buttonSize)
                            .foregroundColor(.pink)
                    }
                }

                HStack {
                    Button(action: togglePauseResume) {
                        Text(isPaused ? "Resume" : "Pause")
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 40)

                    Button("Reset") {
                        reset()
                    }
                    .padding(.top, 20)
                }
                .foregroundColor(.pink)
            }
            .padding()
        }

        func startPlayback() {
            showProgress = true
            playbackProgress = 0.0
            invalidateTimer()
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if playbackProgress < 1.0 {
                    playbackProgress += 0.05
                } else {
                    stopPlayback()
                }
            }
        }

        func stopPlayback() {
            invalidateTimer()
            showProgress = false
            isPaused = false
        }

        func reset() {
            invalidateTimer()
            playbackProgress = 0.0
            showProgress = false
            isPaused = false
        }

        func togglePauseResume() {
            if isPaused {
                resume()
            } else {
                pause()
            }
        }

        func pause() {
            invalidateTimer()
            isPaused = true
        }

        func resume() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if playbackProgress < 1.0 {
                    playbackProgress += 0.05
                } else {
                    stopPlayback()
                }
            }
            isPaused = false
        }

        func invalidateTimer() {
            timer?.invalidate()
            timer = nil
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
