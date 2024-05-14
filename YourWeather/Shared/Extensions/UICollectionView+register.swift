//
//  UICollectionView+register.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where  T: ReusingCell {
        let nib = T.nib
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T   where  T: ReusingCell {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier , for: indexPath) as! T
    }
}

