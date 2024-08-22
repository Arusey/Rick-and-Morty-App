//
//  UIImage+.swift
//  Rick And Morty
//
//  Created by Kevin Lagat on 22/08/2024.
//

import Foundation
import UIKit
extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 32)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
