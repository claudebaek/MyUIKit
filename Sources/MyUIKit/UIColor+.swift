//
//  UIColo+.swift
//  MyRealTripTraveler
//
//  Created by dongyoung.lee on 2021/05/10.
//  Copyright © 2021 myrealtrip. All rights reserved.
//

import UIKit

extension UIColor {
    static func asset(named assetName: String) -> UIColor {
        if let color = UIColor(named: assetName) {
            return color
        } else {
            let userInfo: [String: Any] = [
                NSLocalizedDescriptionKey: NSLocalizedString("missing color asset name", comment: "")
            ]
//            NonFatalEventRecorder.logError(
//                domain: NSCocoaErrorDomain,
//                type: .defensive,
//                userInfo: userInfo
//            )
            return .black
        }
    }
}

extension UIColor {

    static var blue50: UIColor {
        asset(named: "blue-50")
    }

    static var blue80: UIColor {
        asset(named: "blue-80")
    }

    static var blue100: UIColor {
        asset(named: "blue-100")
    }

    static var blue200: UIColor {
        asset(named: "blue-200")
    }

    static var blue300: UIColor {
        asset(named: "blue-300")
    }

    static var blue400: UIColor {
        asset(named: "blue-400")
    }

    static var blue500: UIColor {
        asset(named: "blue-500")
    }

    static var blue600: UIColor {
        asset(named: "blue-600")
    }

    static var blue700: UIColor {
        asset(named: "blue-700")
    }

    static var blue800: UIColor {
        asset(named: "blue-800")
    }

    static var blue900: UIColor {
        asset(named: "blue-900")
    }

}

extension UIColor {

    static var gray50: UIColor {
        asset(named: "gray-50")
    }

    static var gray60: UIColor {
        asset(named: "gray-60")
    }

    static var gray80: UIColor {
        asset(named: "gray-80")
    }

    static var gray100: UIColor {
        asset(named: "gray-100")
    }

    static var gray200: UIColor {
        asset(named: "gray-200")
    }

    static var gray300: UIColor {
        asset(named: "gray-300")
    }

    static var gray400: UIColor {
        asset(named: "gray-400")
    }

    static var gray500: UIColor {
        asset(named: "gray-500")
    }

    static var gray600: UIColor {
        asset(named: "gray-600")
    }

    static var gray700: UIColor {
        asset(named: "gray-700")
    }

    static var gray800: UIColor {
        asset(named: "gray-800")
    }

    static var gray900: UIColor {
        asset(named: "gray-900")
    }
    
    static var gray1000: UIColor {
        asset(named: "gray-1000")
    }
}

extension UIColor {

    static var green50: UIColor {
        asset(named: "green-50")
    }

    static var green80: UIColor {
        asset(named: "green-80")
    }

    static var green100: UIColor {
        asset(named: "green-100")
    }

    static var green200: UIColor {
        asset(named: "green-200")
    }

    static var green300: UIColor {
        asset(named: "green-300")
    }

    static var green400: UIColor {
        asset(named: "green-400")
    }

    static var green500: UIColor {
        asset(named: "green-500")
    }

    static var green600: UIColor {
        asset(named: "green-600")
    }

    static var green700: UIColor {
        asset(named: "green-700")
    }

    static var green800: UIColor {
        asset(named: "green-800")
    }

    static var green900: UIColor {
        asset(named: "green-900")
    }

}

extension UIColor {

    static var red50: UIColor {
        asset(named: "red-50")
    }

    static var red80: UIColor {
        asset(named: "red-80")
    }

    static var red100: UIColor {
        asset(named: "red-100")
    }

    static var red200: UIColor {
        asset(named: "red-200")
    }

    static var red300: UIColor {
        asset(named: "red-300")
    }

    static var red400: UIColor {
        asset(named: "red-400")
    }

    static var red500: UIColor {
        asset(named: "red-500")
    }

    static var red600: UIColor {
        asset(named: "red-600")
    }

    static var red700: UIColor {
        asset(named: "red-700")
    }

    static var red800: UIColor {
        asset(named: "red-800")
    }

    static var red900: UIColor {
        asset(named: "red-900")
    }

}

extension UIColor {

    static var yellow50: UIColor {
        asset(named: "yellow-50")
    }

    static var yellow80: UIColor {
        asset(named: "yellow-80")
    }

    static var yellow100: UIColor {
        asset(named: "yellow-100")
    }

    static var yellow200: UIColor {
        asset(named: "yellow-200")
    }

    static var yellow300: UIColor {
        asset(named: "yellow-300")
    }

    static var yellow400: UIColor {
        asset(named: "yellow-400")
    }

    static var yellow500: UIColor {
        asset(named: "yellow-500")
    }

    static var yellow600: UIColor {
        asset(named: "yellow-600")
    }

    static var yellow700: UIColor {
        asset(named: "yellow-700")
    }

    static var yellow800: UIColor {
        asset(named: "yellow-800")
    }

    static var yellow900: UIColor {
        asset(named: "yellow-900")
    }

}

public extension UIColor {

    static var bookingcomBlue: UIColor {
        asset(named: "bookingcomBlue")
    }

    static var bookingcomText: UIColor {
        asset(named: "bookingcomText")
    }

    static var bookingcomScore: UIColor {
        asset(named: "bookingcomScore")
    }

    static var bookingcomReviewCount: UIColor {
        asset(named: "bookingcomReviewCount")
    }

    static var jungleGreen: UIColor {
        asset(named: "jungleGreen")
    }

    static var reviewStar: UIColor {
        asset(named: "reviewStar")
    }
    
    static var highlightLight: UIColor {
        asset(named: "highlightLight")
    }
    
    static var highlightDark: UIColor {
        asset(named: "highlightDark")
    }
    
    static var highlightDark2: UIColor {
        asset(named: "highlightDark-2")
    }
    
    static var kakaoText: UIColor {
        asset(named: "kakaoText")
    }
}
