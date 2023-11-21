//
//  UIView+.swift
//  NotebookStudy
//
//  Created by 백두산 on 2022/12/10.
//

import UIKit

public extension UIView {
    static var highlightViewTag = 191819

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    /// view를 좌우로 빠르게 흔들어주는 애니메이션
    ///
    /// - Parameter duration: duration
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]

        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map { (degrees: Double) -> Double in
            let radians: Double = (Double.pi * degrees) / 180.0
            return radians
        }

        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }

    func dropShadow(color: UIColor = .black, opacity: Float = 1.0, radius: Float = 1, offset: CGSize = CGSize(width: 0, height: 0)) {

        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = CGFloat(radius)

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true

        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    /// 위시버튼 클릭시 애니메이션
    func wishAction() {
        UIView.animate(withDuration: 0.13,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.transform = CGAffineTransform.identity
                        }})
    }

    func showAction(duration: Double, scale: CGFloat) {
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: duration,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.transform = CGAffineTransform.identity
                        }})
    }

    func hideAction(duration: Double) {
        UIView.animate(withDuration: duration,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1) },
                       completion: { _ in
                        self.transform = CGAffineTransform.identity
        })
    }

    func selectAction(duration: (begin: CFTimeInterval, finish: CFTimeInterval) = (0.13, 0.6), scale: CGFloat = 1.3, completeHandler: (() -> Void)?) {
        UIView.animate(withDuration: duration.begin,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: scale, y: scale) },
                       completion: { _ in
                        UIView.animate(withDuration: duration.finish, animations: {
                            self.transform = CGAffineTransform.identity
                        }, completion: { (_) in
                            completeHandler?()
                        })
        })
    }

    func upscaleAction(duration: CFTimeInterval = 0.25, scale: CGFloat = 1.3, completeHandler: (() -> Void)?) {
        UIView.animate(withDuration: duration,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: scale, y: scale) },
                       completion: { _ in
                        completeHandler?()
        })
    }

    func defaultScaleAction(duration: CFTimeInterval = 0.25, completeHandler: (() -> Void)?) {
        UIView.animate(withDuration: duration,
                       animations: {
                        self.transform = CGAffineTransform.identity },
                       completion: { _ in
                        completeHandler?()
        })
    }

    func dehighlight() {
        let highlightedViews = self.subviews.filter { ($0.tag == UIView.highlightViewTag) }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            for v in highlightedViews {
                v.removeFromSuperview()
            }
        }
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    func borders(for edges: [UIRectEdge], width: CGFloat = 1, color: UIColor = .black) {
        if edges.contains(.all) {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
        } else {
            let allSpecificBorders: [UIRectEdge] = [.top, .bottom, .left, .right]

            for edge in allSpecificBorders {
                if let v = viewWithTag(Int(edge.rawValue)) {
                    v.removeFromSuperview()
                }

                if edges.contains(edge) {
                    let v = UIView()
                    v.tag = Int(edge.rawValue)
                    v.backgroundColor = color
                    v.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(v)

                    var horizontalVisualFormat = "H:"
                    var verticalVisualFormat = "V:"

                    switch edge {
                    case UIRectEdge.bottom:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "[v(\(width))]-(0)-|"
                    case UIRectEdge.top:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v(\(width))]"
                    case UIRectEdge.left:
                        horizontalVisualFormat += "|-(0)-[v(\(width))]"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    case UIRectEdge.right:
                        horizontalVisualFormat += "[v(\(width))]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    default:
                        break
                    }

                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                }
            }
        }
    }

    func mask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = .evenOdd
        }
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

// MARK: - CALayer
extension CALayer {
    func roundCorners(corners: UIRectCorner, radius: CGFloat, viewBounds: CGRect) {

        let maskPath = UIBezierPath(roundedRect: viewBounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        mask = shape
    }
}

// MARK: - NibLoadableView
protocol NibLoadableView: AnyObject {}

extension NibLoadableView where Self: UIView {
    static var NibName: String {
        return String(describing: self)
    }
}

extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

extension UIView {
    func animation(hidden: Bool, duration: TimeInterval = 0.25) {
        if hidden {
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }) { (_) in
                self.isHidden = true
            }
        } else {
            self.isHidden = false
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1
            })
        }
    }
}

public final class ModuleTestClass: ModuleTestProtocol {
    
    public init() {
        
    }
}

public protocol AAA {
    func test(a: String, b: Any?) -> Bool

}

public protocol ModuleTestProtocol: AAA {
    
}


extension ModuleTestProtocol {
    public func test(a: String, b: Any?) -> Bool {
        print("ModuleTestClass")
        return true
    }
}
