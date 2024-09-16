//
//  Data+Extensions.swift
//  HackNews
//
//  Created by Simone Sella on 15/09/24.
//

import Foundation

//This code has been sourced online
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
