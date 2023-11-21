//
//  UIButton+Traveler.swift
//  MyRealTripTraveler
//
//  Created by YoungHoo Kim on 2018. 3. 14..
//  Copyright © 2018년 myrealtrip. All rights reserved.
//

import UIKit

// swiftlint:disable line_length

extension UIButton {
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
                setTitle(.none, for: .normal)
            }

            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))

            setAttributedTitle(attributedString, for: .normal)
        }

        get {
            if let currentLetterSpace = attributedTitle(for: .normal)?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }

    @IBInspectable
    var MRTTitleColorAlpha: CGFloat {
        get {
            // UIColor to rgbaValue
            var alpha: CGFloat = 1.0
            guard let _ = self.titleLabel?.textColor.getRed(nil, green: nil, blue: nil, alpha: &alpha) else { return 1.0 }
            return alpha
        }
        set {
            self.titleLabel?.textColor = self.titleLabel?.textColor.withAlphaComponent(newValue)
        }
    }

    @IBInspectable
    var systemFontTypeface: String {
        get {
            return self.titleLabel?.font.fontName ?? "regular"
        }
        set {
            var fontName: UIFont {
                let size = self.titleLabel?.font.pointSize ?? 10
                switch newValue {
                case "regular":
                    return UIFont.systemFont(ofSize: size)
                case "medium":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
                case "bold":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
                case "semibold":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
                case "light":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
                case "thin":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
                default:
                    return UIFont.systemFont(ofSize: size)
                }
            }

            if let att = self.titleLabel?.attributedText?.attributes(at: 0, effectiveRange: nil), let attrText = self.attributedTitle(for: .normal) {
                var attr = convertFromNSAttributedStringKeyDictionary(att)
                attr[convertFromNSAttributedStringKey(NSAttributedString.Key.font)] = fontName

                let attributedTitle = NSAttributedString(string: attrText.string, attributes: convertToOptionalNSAttributedStringKeyDictionary(attr))
                self.setAttributedTitle(attributedTitle, for: .normal)

            } else {
                self.titleLabel?.font = fontName
            }
        }
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))

        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(backgroundImage, for: state)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

extension UIButton {
    private struct AssociatedKeys {
        static var useHighlightColor: Bool = false
        static var highlightedColor: UIColor?
        static var prevTintColor: UIColor?
    }

    var useHighlightColor: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.useHighlightColor) as? Bool
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.useHighlightColor, newValue as Bool?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var highlightedColor: UIColor? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.highlightedColor) as? UIColor) ?? .highlightLight
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.highlightedColor, newValue as UIColor?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var prevTintColor: UIColor? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.prevTintColor) as? UIColor) ?? nil
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.prevTintColor, newValue as UIColor?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    open override var isHighlighted: Bool {
        didSet {
//            if isHighlighted {
//                if self.prevTintColor == nil {
//                    self.prevTintColor = self.tintColor
//                }
//                self.tintColor = UIColor.RGBA(red: 0, g: 0, b: 0, a: 0.5)
//            } else {
//                self.tintColor = self.prevTintColor
//                self.prevTintColor = nil
//            }
//
//            guard let useHighlightColor = useHighlightColor, useHighlightColor else { return }
//            if isHighlighted {
//                highlight(color: highlightedColor ?? .highlightLight)
//            } else {
//                dehighlight()
//            }
        }
    }

    func setBorder(width: CGFloat, color: UIColor, animationDuration: Double? = nil) {
        if let duration = animationDuration {
            UIView.animate(withDuration: duration) { [weak self] in
                self?.layer.borderColor = color.cgColor
                self?.layer.borderWidth = width
            }
        } else {
            layer.borderColor = color.cgColor
            layer.borderWidth = width
        }
    }
}

extension UIButton {
    func alignTextBelow(spacing: CGFloat = 4.0) {
        guard let image = imageView?.image,
              let titleLabel = titleLabel,
              let titleText = titleLabel.text else { return }
        
        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])
        
        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}

