//
//  Style+Traveler.swift
//  traveler
//
//  Created by YoungHoo Kim on 2018. 9. 3..
//  Copyright © 2018년 myrealtrip. All rights reserved.
//
import UIKit
import SwiftRichString

extension Style {
    static func font(_ font: UIFont) -> Style {
        return Style {
            $0.font = font
        }
    }

    func font(_ font: UIFont) -> Style {
        self.font = font
        return self
    }
    
    func color(_ color: UIColor) -> Style {
        self.color = color
        return self
    }

    func lineSpacing(_ spacing: CGFloat) -> Style {
        self.lineSpacing = spacing
        return self
    }

    func strikeColor(_ name: UIColor) -> Style {
        self.strikethrough = (style: NSUnderlineStyle.single, color: name)
        return self
    }

    func lineBreak(_ lineBreak: NSLineBreakMode) -> Style {
        self.lineBreakMode = lineBreak
        return self
    }

    func align(_ alignment: NSTextAlignment) -> Style {
        self.alignment = alignment
        return self
    }

    func kern(_ kerning: CGFloat = -0.3) -> Style {
        self.kerning = Kerning.point(kerning)
        return self
    }
    
    func lineHeightMultiple(_ multiple: CGFloat = 1) -> Style {
        self.lineHeightMultiple = multiple
        return self
    }

    func underline(color: UIColor, style: NSUnderlineStyle) -> Style {
        self.underline = (style: style, color: color)
        return self
    }
    
    func lineBreakStrategy(_ strategy: StyleLineBreakStrategy) -> Style {
        guard let strategyType = strategy.type else {
             return self
        }
        paragraph.lineBreakStrategy = strategyType
        return self
    }
    
    func shadow(
        color: UIColor = UIColor.white,
        size: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 0
    ) -> Style {
        let shadow = NSShadow()
        shadow.shadowOffset = size
        shadow.shadowColor = color
        shadow.shadowBlurRadius = radius
        self.shadow = shadow
        return self
    }
}

extension Style {
    enum StyleLineBreakStrategy {
        case standard
        case hangulWordPriority
        case pushOut
        
        var type: NSMutableParagraphStyle.LineBreakStrategy? {
            switch self {
            case .standard:
                guard #available(iOS 14.0, *) else {
                    return nil
                }
                return .standard
            case .hangulWordPriority:
                guard #available(iOS 14.0, *) else {
                    return nil
                }
                return .hangulWordPriority
            case .pushOut:
                return .pushOut
            }
        }
    }
}
