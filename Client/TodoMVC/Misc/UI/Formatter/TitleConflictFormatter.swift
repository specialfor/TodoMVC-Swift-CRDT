//
//  TitleConflictFormatter.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 04.05.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

struct TitleConflictFormatter {
    static func format(titles: [String]) -> NSAttributedString {
        guard titles.count > 1 else {
            return NSAttributedString(string: titles.first ?? "")
        }
        
        let text = "Conflict: [\(titles.joined(separator: ", "))]"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.red.cgColor,
            range: .init(location: 0, length: 9))
        
        return attributedString
    }
}
