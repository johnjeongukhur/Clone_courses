//
//  Extensions.swift
//  LetsMeet
//
//  Created by John Hur on 2021/05/31.
//

import Foundation
import UIKit

extension Date {
    
    func longDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func stringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMMyyyyHHmmss"
        return dateFormatter.string(from: self)
    }
    // 사용자에게 주어진 'Date'를 이용하여 날짜를 계산하는 함수
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else
            { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else
            { return 0 }
        
        return end - start
        
    }
}

// UIColor는 UIKit에 속해있음
extension UIColor {
    
    func primary() -> UIColor {
        return UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1)
    }
    
    func tapBarUnselected() -> UIColor {
        return UIColor(red: 255/255, green: 216/255, blue: 223/255, alpha: 1)
    }
    
    static var sampleRed = UIColor(red: 252 / 255, green: 70 / 255, blue: 93 / 255, alpha: 1)
    static var sampleGreen = UIColor(red: 49 / 255, green: 193 / 255, blue: 109 / 255, alpha: 1)
    
}


extension UIImage {
    
    var isPortrait : Bool { return size.height > size.width }
    var isLandscape : Bool { return size.width > size.height }
    var breadth : CGFloat { return min(size.width, size.height) }
    var breadthSize : CGSize { return CGSize(width: breadth, height: breadth) }
    var breadthRect : CGRect { return CGRect(origin: .zero, size: breadthSize) }
    
    var circleMasked: UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        
        defer { UIGraphicsEndImageContext() }
        
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
        
    }
    
}

extension NSAttributedString.Key {

  static var overlayAttributes: [NSAttributedString.Key: Any] = [
    // swiftlint:disable:next force_unwrapping
    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 42)!,
    NSAttributedString.Key.kern: 5.0
  ]
}


extension UIView {
    
    func applyShadow(radius: CGFloat,
                     opacity: Float,
                     offset: CGSize,
                     color: UIColor = .black) {
      layer.shadowRadius = radius
      layer.shadowOpacity = opacity
      layer.shadowOffset = offset
      layer.shadowColor = color.cgColor
    }


  @discardableResult
  func anchor(top: NSLayoutYAxisAnchor? = nil,
              left: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              paddingTop: CGFloat = 0,
              paddingLeft: CGFloat = 0,
              paddingBottom: CGFloat = 0,
              paddingRight: CGFloat = 0,
              width: CGFloat = 0,
              height: CGFloat = 0) -> [NSLayoutConstraint] {
    translatesAutoresizingMaskIntoConstraints = false

    var anchors = [NSLayoutConstraint]()

    if let top = top {
      anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
    }
    if let left = left {
      anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
    }
    if let bottom = bottom {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
    }
    if let right = right {
      anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
    }
    if width > 0 {
      anchors.append(widthAnchor.constraint(equalToConstant: width))
    }
    if height > 0 {
      anchors.append(heightAnchor.constraint(equalToConstant: height))
    }

    anchors.forEach { $0.isActive = true }

    return anchors
  }

  @discardableResult
  func anchorToSuperview() -> [NSLayoutConstraint] {
    return anchor(top: superview?.topAnchor,
                  left: superview?.leftAnchor,
                  bottom: superview?.bottomAnchor,
                  right: superview?.rightAnchor)
  }
}

