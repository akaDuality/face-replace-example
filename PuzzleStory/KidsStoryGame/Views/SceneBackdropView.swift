import SwiftUI

/// Paints the wide scrolling backdrop for a story using only gradients
/// and simple shapes – no image assets needed.
struct SceneBackdropView: View {
    let backdrop: SceneBackdrop

    var body: some View {
        switch backdrop {
        case .park:  park
        case .beach: beach
        case .farm:  farm
        }
    }

    // MARK: - Park

    private var park: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.55, green: 0.82, blue: 1.0),
                             Color(red: 0.82, green: 0.94, blue: 1.0)],
                    startPoint: .top, endPoint: .bottom
                )

                // Rolling grass
                Ellipse()
                    .fill(Color(red: 0.45, green: 0.78, blue: 0.40))
                    .frame(width: geo.size.width * 1.4, height: geo.size.height * 0.9)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 1.05)

                // Winding path
                Capsule()
                    .fill(Color(red: 0.90, green: 0.82, blue: 0.60))
                    .frame(width: geo.size.width * 1.2, height: geo.size.height * 0.12)
                    .rotationEffect(.degrees(-4))
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.82)
            }
        }
    }

    // MARK: - Beach

    private var beach: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.55, green: 0.85, blue: 1.0),
                             Color(red: 0.85, green: 0.96, blue: 1.0)],
                    startPoint: .top, endPoint: .bottom
                )

                // Sea
                Rectangle()
                    .fill(LinearGradient(
                        colors: [Color(red: 0.20, green: 0.55, blue: 0.85),
                                 Color(red: 0.35, green: 0.72, blue: 0.92)],
                        startPoint: .top, endPoint: .bottom))
                    .frame(height: geo.size.height * 0.32)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.55)

                // Sand
                Ellipse()
                    .fill(Color(red: 0.96, green: 0.90, blue: 0.66))
                    .frame(width: geo.size.width * 1.4, height: geo.size.height * 0.6)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 1.05)
            }
        }
    }

    // MARK: - Farm

    private var farm: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.98, green: 0.86, blue: 0.55),
                             Color(red: 0.70, green: 0.88, blue: 1.0)],
                    startPoint: .top, endPoint: .bottom
                )

                // Back hills
                Ellipse()
                    .fill(Color(red: 0.40, green: 0.72, blue: 0.38))
                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.7)
                    .position(x: geo.size.width * 0.3, y: geo.size.height * 0.95)
                Ellipse()
                    .fill(Color(red: 0.46, green: 0.78, blue: 0.42))
                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.7)
                    .position(x: geo.size.width * 0.75, y: geo.size.height * 0.95)

                // Front field
                Rectangle()
                    .fill(Color(red: 0.52, green: 0.80, blue: 0.40))
                    .frame(height: geo.size.height * 0.28)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.92)
            }
        }
    }
}
