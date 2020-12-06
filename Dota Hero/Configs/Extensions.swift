//
//  Extensions.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import Foundation
import UIKit

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

extension Array where Element: Equatable {
    func contains(array: [Element]) -> Bool {
        for item in array {
            if self.contains(item) { return true }
        }
        return false
    }
}

extension UILabel {
    func properties(parent:UIView, text:String?, size:CGFloat, weight:UIFont.Weight){
        parent.addSubview(self)
        if let text = text {
            self.text = NSLocalizedString(text, comment: "")
        }
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}

extension UIWindow {
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
