//
//  ComponentPartsButton.swift
//  traveler
//
//  Created by 홍동현 on 2022/08/15.
//  Copyright © 2022 myrealtrip. All rights reserved.
//

import UIKit
import SwiftRichString
import SnapKit

open class ComponentPartsButton: UIButton {
    
    public enum Size {
        case small
        case medium
        case large
        
        var inset: UIEdgeInsets {
            switch self {
            case .small:
                return UIEdgeInsets(top: 9.5, left: 14, bottom: 9.5, right: 14)
            case .medium:
                return UIEdgeInsets(top: 13.5, left: 18, bottom: 13.5, right: 18)
            case .large:
                return UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
            }
        }
        var fontStyle: Style {
            switch self {
            case .small, .medium:
                return Style.font(.semiBold(size: 15)).kern(-0.15)
            case .large:
                return Style.font(.bold(size: 18))
            }
        }
        var radius: CGFloat {
            switch self {
            case .small:
                return 20
            case .medium:
                return 24
            case .large:
                return 28
            }
        }
        var height: CGFloat {
            switch self {
            case .small:
                return 40
            case .medium:
                return 48
            case .large:
                return 56
            }
        }
    }
    
    public enum Priority {
        case high
        case normal
        case low
        case lower
        
        var foregroundColor: (normal: UIColor, highlighted: UIColor, disabled: UIColor) {
            switch self {
            case .high:
                return (normal: .white, highlighted: .white, disabled: .white)
            case .normal:
                return (normal: .white, highlighted: .gray100, disabled: .gray400)
            case .low:
                return (normal: .gray1000, highlighted: .gray700, disabled: .gray400)
            case .lower:
                return (normal: .gray1000, highlighted: .gray700, disabled: .gray300)
            }
        }
        var backgroundColor: (normal: UIColor, highlighted: UIColor, disabled: UIColor) {
            switch self {
            case .high:
                return (normal: .blue500, highlighted: .blue600, disabled: .blue200)
            case .normal:
                return (normal: .gray1000, highlighted: .gray900, disabled: .gray80)
            case .low:
                return (normal: .gray80, highlighted: .gray1000.withAlphaComponent(0.05), disabled: .gray80)
            case .lower:
                return (normal: .white, highlighted: .gray1000.withAlphaComponent(0.05), disabled: .white)
            }
        }
        var hasBorder: Bool {
            switch self {
            case .high, .normal, .low:
                return false
            case .lower:
                return true
            }
        }
    }
    
    public let size: Size
    public var priority: Priority
    
    public init(size: Size, priority: Priority) {
        self.size = size
        self.priority = priority
        super.init(frame: .zero)
        setupLayouts()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitle(_ text: String?) {
        let fontStyle = size.fontStyle
        let fontColor = priority.foregroundColor
        setAttributedTitle(text?.set(style: fontStyle.color(fontColor.normal)), for: .normal)
        setAttributedTitle(text?.set(style: fontStyle.color(fontColor.highlighted)), for: .highlighted)
        setAttributedTitle(text?.set(style: fontStyle.color(fontColor.disabled)), for: .disabled)
    }
    
    func setImage(_ image: UIImage?) {
        let imageTintColor = priority.foregroundColor
        setImage(image?.withTintColor(imageTintColor.normal), for: .normal)
        setImage(image?.withTintColor(imageTintColor.highlighted), for: .highlighted)
        setImage(image?.withTintColor(imageTintColor.disabled), for: .disabled)
    }
    
    func setSelectedImage(_ image: UIImage?) {
        setImage(image, for: .selected)
    }

        
    private func setupLayouts() {
        contentEdgeInsets = size.inset
        layer.cornerRadius = size.radius
        clipsToBounds = true
        snp.makeConstraints {
            $0.height.equalTo(size.height)
        }
        setBackgroundColor()
        setBorder()
    }
    
    func setBackgroundColor() {
        let backgroundColor = priority.backgroundColor
        setBackgroundColor(backgroundColor.normal, for: .normal)
        setBackgroundColor(backgroundColor.highlighted, for: .highlighted)
        setBackgroundColor(backgroundColor.disabled, for: .disabled)
    }
    
    private func setBorder() {
        guard priority.hasBorder else { return }
        layer.borderColor = UIColor.gray100.cgColor
        layer.borderWidth = 1.5
        addTarget(self, action: #selector(didPressed), for: [.touchDown])
        addTarget(self,
                  action: #selector(didReleased),
                  for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    public func setLayerClear() {
        layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc func didPressed() {
        layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc private func didReleased() {
        layer.borderColor = UIColor.gray100.cgColor
    }
}

public class TabbarComponentPartsButton: ComponentPartsButton {
    
    public func setUntap() {
        priority = .lower
        setTitle(titleLabel?.text)
        setBackgroundColor()
    }
    
    public func setTap() {
        priority = .normal
        setTitle(titleLabel?.text)
        setBackgroundColor()
    }
}

public class TabbarFilterButton: UIButton {
    
    public init() {
        super.init(frame: .zero)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                unsetBorder()
//            } else {
//                setBorder()
//            }
//            sizeToFit()
//        }
//    }
    
    public func setTitle(_ text: String?) {
        let fontStyle = Style.font(.semiBold(size: 13)).kern(-0.1)
        setAttributedTitle(text?.set(style: fontStyle.color(.gray1000)), for: .normal)
        setAttributedTitle(text?.set(style: fontStyle.color(.white)), for: .selected)
    }

    private func setupLayouts() {
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        layer.cornerRadius = 8
        clipsToBounds = true
        snp.makeConstraints {
            $0.height.equalTo(34)
        }
        setBackgroundColor()
//        setBorder()
        
        setImage(UIImage(named: "ico_check"), for: .selected)
    }
    
    func setBackgroundColor() {
        setBackgroundColor(.white, for: .normal)
        setBackgroundColor(.gray1000, for: .selected)
    }
    
    private func setBorder() {
        layer.borderColor = UIColor.gray200.cgColor
        layer.borderWidth = 1
    }
    
    private func unsetBorder() {
        layer.borderColor = UIColor.clear.cgColor
//        layer.borderWidth = 0
    }
}
