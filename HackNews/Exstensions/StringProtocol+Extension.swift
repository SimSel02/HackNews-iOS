//
//  StringProtocol+Extension.swift
//  HackNews
//
//  Created by Simone Sella on 15/09/24.
//

import Foundation

//This code has been sourced online
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
