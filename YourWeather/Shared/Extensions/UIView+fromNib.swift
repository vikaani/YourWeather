//
// UIView+fromNib.swift
//  YourWeather
//
//  Created by Vika on 01.05.2024.
//

import UIKit

public extension UIView {
    class func fromNib<T: UIView>() -> T {
         Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

