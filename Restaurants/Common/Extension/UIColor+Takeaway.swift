//
//  UIColor+Takeaway.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var taOrange: UIColor {
        return colorFrom(r: 255, g: 128, b: 0)
    }
    
    private static func colorFrom(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
}
