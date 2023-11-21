//
//  UIFont+Traveler.swift
//  traveler
//
//  Created by 김영후 on 2017. 11. 16..
//  Copyright © 2017년 myrealtrip. All rights reserved.
//

import UIKit

extension UIFont {
    class func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Regular", size: size) ?? UIFont.systemFont(ofSize: size,
                                                                                   weight: UIFont.Weight.regular)
    }

    class func light(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Light", size: size) ?? UIFont.systemFont(ofSize: size,
                                                                                 weight: UIFont.Weight.light)
    }

    class func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size) ?? UIFont.systemFont(ofSize: size,
                                                                                weight: UIFont.Weight.bold)
    }

    class func semiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size,
                                                                                    weight: UIFont.Weight.semibold)
    }

    class func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Medium", size: size) ?? UIFont.systemFont(ofSize: size,
                                                                                  weight: UIFont.Weight.medium)
    }
}
