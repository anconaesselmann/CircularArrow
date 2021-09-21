//  Created by Axel Ancona Esselmann on 9/20/21.
//

import SwiftUI

struct CircularArrow: Shape {

    enum Direction: CustomStringConvertible {
        case clockwise, counterClockwise, bidirectional

        var description: String {
            switch self {
            case .clockwise:
                return "->"
            case .counterClockwise:
                return "<-"
            case .bidirectional:
                return "<->"
            }
        }

        var toggled: Direction {
            switch self {
            case .clockwise: return .counterClockwise
            case .counterClockwise: return .bidirectional
            case .bidirectional: return .clockwise
            }
        }
    }

    var radius: CGFloat
    var startAngle: Angle
    var length: CGFloat
    var tipAngle: Angle
    var tipSideLength: CGFloat
    var tipCompensation: Angle
    var direction: Direction

    func path(in rect: CGRect) -> Path {
        Path { p in
            let offset: Angle = -.radians(.pi / 2)
            let circumferance = 2 * .pi * radius
            let angle = length / circumferance * 2 * .pi

            let start = startAngle + offset
            let end = startAngle + .radians(Double(angle)) + offset

            p.addArc(center: rect.center, radius: radius, startAngle: start, endAngle: end, clockwise: false)

            if direction == .clockwise || direction == .bidirectional {
                let v_toTip = CGPoint(x: radius, y: 0).rotated(by: end)

                let vc_outsideHead = CGPoint(x: 1, y: 0).rotated(by: end - tipAngle + tipCompensation) * tipSideLength
                let vc_insideHead = -CGPoint(x: 1, y: 0).rotated(by: end + tipAngle + tipCompensation) * tipSideLength

                p.move(to: v_toTip + rect.center)
                p.addLine(to: v_toTip + vc_outsideHead + rect.center)
                p.move(to: v_toTip + rect.center)
                p.addLine(to: v_toTip + vc_insideHead + rect.center)

            }
            if direction == .counterClockwise || direction == .bidirectional {
                let v_toTail = CGPoint(x: radius, y: 0).rotated(by: start)

                let vcc_outsideHead = CGPoint(x: 1, y: 0).rotated(by: start + tipAngle + tipCompensation) * tipSideLength
                let vcc_insideHead = -CGPoint(x: 1, y: 0).rotated(by: start - tipAngle + tipCompensation) * tipSideLength

                p.move(to: v_toTail + rect.center)
                p.addLine(to: v_toTail + vcc_outsideHead + rect.center)
                p.move(to: v_toTail + rect.center)
                p.addLine(to: v_toTail + vcc_insideHead + rect.center)
            }
        }
    }
}

struct CircularArrow_Previews: PreviewProvider {
    static let style = StrokeStyle(
        lineWidth: 4,
        lineCap: .round,
        lineJoin: .round,
        miterLimit: 0,
        dash: [],
        dashPhase: 0
    )

    static var previews: some View {
        CircularArrow(
            radius: 80,
            startAngle: .zero,
            length: 40,
            tipAngle: .radians(.pi / 4),
            tipSideLength: 20,
            tipCompensation: .radians(-.pi / 32),
            direction: .clockwise
        ).stroke(
            Color.black,
            style: style
        )
        .frame(width: 210, height: 210)
        .previewLayout(.sizeThatFits)
    }
}
