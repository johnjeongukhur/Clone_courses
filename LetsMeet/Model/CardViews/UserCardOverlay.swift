//
//  UserCardOverlay.swift
//  LetsMeet
//
//  Created by John Hur on 2021/06/15.
//

import Shuffle_iOS
import UIKit

class UserCardOverlay: UIView {
    // SwipeDirection은 Shuffle의 라이브러리
    init(direction: SwipeDirection) {
        super.init(frame: .zero)
        
        switch direction {
        case .left:
            createLeftOverlay()
        case .right:
            createRightOverlay()
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // 카드가 왼쪽으로 움직이는 함수
    private func createLeftOverlay() {
        let leftTextView = TinderCardOverlayLabelView(withTitle: "NOPE", color: .sampleRed, rotation: CGFloat.pi/10)
        
        addSubview(leftTextView)
        leftTextView.anchor(top: topAnchor,
                            right: rightAnchor,
                            paddingTop: 30,
                            paddingRight: 14)
    }
    
    // 카드가 오른쪽으로 움직이는 함수
    private func createRightOverlay() {
        let rightTextView = TinderCardOverlayLabelView(withTitle: "LIKE", color: .sampleGreen, rotation: -CGFloat.pi/10)
        
        addSubview(rightTextView)
        rightTextView.anchor(top: topAnchor,
                            left: leftAnchor,
                            paddingTop: 26,
                            paddingRight: 14)
    }
}
    
private class TinderCardOverlayLabelView: UIView {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()

  init(withTitle title: String, color: UIColor, rotation: CGFloat) {
    super.init(frame: CGRect.zero)
    layer.borderColor = color.cgColor
    layer.borderWidth = 4
    layer.cornerRadius = 4
    transform = CGAffineTransform(rotationAngle: rotation)

    addSubview(titleLabel)
    titleLabel.textColor = color
    titleLabel.attributedText = NSAttributedString(string: title,
                                                   attributes: NSAttributedString.Key.overlayAttributes)
    titleLabel.anchor(top: topAnchor,
                      left: leftAnchor,
                      bottom: bottomAnchor,
                      right: rightAnchor,
                      paddingLeft: 8,
                      paddingRight: 3)
  }

  required init?(coder aDecoder: NSCoder) {
    return nil
  }
}
