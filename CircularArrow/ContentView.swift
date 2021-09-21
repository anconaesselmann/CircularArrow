//  Created by Axel Ancona Esselmann on 9/20/21.
//

import SwiftUI

struct ContentView: View {
    let style = StrokeStyle(
        lineWidth: 4,
        lineCap: .round,
        lineJoin: .round,
        miterLimit: 0,
        dash: [],
        dashPhase: 0
    )

    @State var rotationSlider: Double = 0
    @State var lengthSlider: Double = 0.25
    @State var radiusSlider: Double = 0.11
    @State var tipAngle: Double = 0.5
    @State var tipSideLength: Double = 0.2
    @State var tipCompensation: Double = 0.5
    @State var isAnimating: Bool = false
    @State private var animationAngle: Angle = .zero
    @State private var direction: CircularArrow.Direction = .clockwise

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 100, height: 100, alignment: .center)
            Group {
                if isAnimating {
                    arrow
                        .rotationEffect(animationAngle)
                        .animation(
                            Animation.linear
                                .repeatForever(autoreverses: direction == .bidirectional)
                                .speed(0.1)
                        )
                } else {
                    arrow
                }
            }
            controlls
        }
    }

    @ViewBuilder
    var arrow: some View {
        CircularArrow(
            radius: max(CGFloat(radiusSlider * 1000) / 2, 1),
            startAngle: .radians(rotationSlider * 2 * .pi),
            length: CGFloat(2 * .pi * (radiusSlider * 1000) / 2 * lengthSlider),
            tipAngle: .radians(.pi / 2 * tipAngle),
            tipSideLength: CGFloat(50 * tipSideLength),
            tipCompensation: .radians((tipCompensation - 0.5) * .pi / 4),
            direction: direction
        ).stroke(style: style)
    }

    @ViewBuilder
    var controlls: some View {
        VStack {
            let padding: CGFloat = 16
            Slider(value: $rotationSlider).padding([.leading, .trailing], padding)
            Slider(value: $lengthSlider).padding([.leading, .trailing], padding)
            Slider(value: $radiusSlider).padding([.leading, .trailing], padding)
            Slider(value: $tipAngle).padding([.leading, .trailing], padding)
            Slider(value: $tipSideLength).padding([.leading, .trailing], padding)
            Slider(value: $tipCompensation).padding([.leading, .trailing], padding)
            HStack {
                Button(action: {
                    isAnimating = false
                    direction = direction.toggled
                }, label: {
                    Text("Toggle \(direction.description)")
                })
                Spacer()
                Toggle(isOn: $isAnimating) {
                    Text("Animate")
                }.onChange(of: isAnimating) { value in
                    if isAnimating {
                        if direction == .clockwise || direction == .bidirectional {
                            animationAngle += .radians(2 * .pi)
                        } else if direction == .counterClockwise {
                            animationAngle -= .radians(2 * .pi)
                        }
                    } else {
                        animationAngle = .zero
                    }
                }.padding([.leading, .trailing], 16)
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
