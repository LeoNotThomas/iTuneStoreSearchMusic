//
//  Collor+AppColor.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 12.10.22.
//

import Foundation
import UIKit

extension UIColor {
    struct AppColor {
        static var navigationBar: UIColor {
            return .blue
        }
        static var navigationItem: UIColor {
            return .white
        }
        
        static func button(disabled: Bool = false) -> UIColor {
            if disabled {
                return .lightGray
            }
            return .blue
        }
    }
}
