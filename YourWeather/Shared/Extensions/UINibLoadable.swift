//
//  UINibLoadable.swift
//  YourWeather
//
//  Created by Vika on 01.05.2024.
//

import UIKit

public protocol NibLoadable {
    func loadFromNib()
}

public extension NibLoadable where Self: UIView {
    func loadFromNib() {
        
        let bundle = Bundle(for: Self.self)
        
        let nibName = (String(describing: type(of: self)) as NSString).components(separatedBy: ".").last!
                
        guard let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {

            print("Could not load nib with name: \(nibName)")
            return
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds

        self.addSubview(view)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

open class XIBView: UIView, NibLoadable {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
        
        awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadFromNib()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
}

