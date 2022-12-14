//
//  Interpolator.swift
//  JCTicker
//
//  Created by zexi chen on 2022-12-13.
//

import Foundation

public protocol Interpolator {
    func interpolate(_ percent: Double) -> Double
}

public class DecelerateInterpolator: Interpolator{
    
    private var power = 2.0
    public init(_ power: Double = 5.0) {
        self.power = power
    }
    
    public func interpolate(_ percent: Double) -> Double {
        return (1.0 - pow(1.0 - percent , power))
    }
    
}

public class OverShootInterpolator: Interpolator{
    
    private var tension = 2.0
    public init(_ tension: Double = 2.0) {
        self.tension = tension
    }
    
    public func interpolate(_ percent: Double) -> Double {
        var t = percent - 1.0
        return t * t * ((tension + 1) * t + tension) + 1.0;
    }
    
}
