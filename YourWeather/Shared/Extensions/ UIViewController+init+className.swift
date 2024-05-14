//
//  UIViewController+init+className.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import UIKit

extension UIViewController {
    static var className: String {
        "\(Self.self)"
    }
    
    convenience init(bundle: Bundle? = nil) {
        self.init(nibName: UIViewController.className, bundle: bundle)
    }
}

