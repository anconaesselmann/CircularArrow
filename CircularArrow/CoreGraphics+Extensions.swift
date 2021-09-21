//  Created by Axel Ancona Esselmann on 9/20/21.
//

import SwiftUI

extension CGPoint {
    func rotated(by theta: Angle) -> CGPoint {
        let cosTheta = CGFloat(cos(theta.radians))
        let sinTheta = CGFloat(sin(theta.radians))
        let x: CGFloat = self.x * cosTheta - self.y * sinTheta
        let y: CGFloat = self.x * sinTheta + self.y * cosTheta
        return CGPoint(x: x, y: y)
    }

    var unit: CGPoint {
        self / lenght
    }

    var lenght: CGFloat {
        return sqrt(x * x + y * y)
    }

    var orth: CGPoint {
        CGPoint(x: -y, y: x)
    }

    var orthUnit: CGPoint {
        orth.unit
    }
}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

func angle(of position: Int, in count: Int) -> Angle {
    .radians(2 * Double.pi / Double(count) * Double(position))
}

prefix func - (lhs: CGPoint) -> CGPoint {
    CGPoint(x: -lhs.x, y: -lhs.y)
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: width / 2, y: height / 2)
    }
}
