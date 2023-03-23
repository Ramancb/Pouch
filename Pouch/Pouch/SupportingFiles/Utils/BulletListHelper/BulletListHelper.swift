//
//  BulletListHelper.swift
//  FLEEK
//
//  Created by apple on 25/02/22.
//

import UIKit

class BulletListHelper {
    static func createBulletedList(fromStringArray strings: [String], font: UIFont? = nil, color:UIColor? = .white, lineHeight:CGFloat = 1.37) -> NSAttributedString {

        let fullAttributedString = NSMutableAttributedString()
        let attributesDictionary: [NSAttributedString.Key: Any]
    
        if let font = font {
            attributesDictionary = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color ?? .white]
        } else {
            attributesDictionary = [NSAttributedString.Key: Any]()
        }
        
   
        for index in 0..<strings.count {
            let bulletPoint: String = "\u{2022}"
            var formattedString: String = "\(bulletPoint) \(strings[index])"
        
            if index < strings.count - 1 {
                formattedString = "\(formattedString)\n"
            }
        
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString, attributes: attributesDictionary)
            let paragraphStyle = BulletListHelper.createParagraphAttribute(line_height: lineHeight)
   attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
        fullAttributedString.append(attributedString)
       }
    
        return fullAttributedString
    }

    private static func createParagraphAttribute(line_height:CGFloat) -> NSParagraphStyle {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 11
//        paragraphStyle.lineSpacing =
        paragraphStyle.lineHeightMultiple = line_height
        return paragraphStyle
    }
}
