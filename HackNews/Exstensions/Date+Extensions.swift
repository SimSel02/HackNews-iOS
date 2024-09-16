//
//  Date+Extensions.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import Foundation

extension Date {
    ///Format returning dd/MM/YY (es. 01/09/24)
    func dateOnly() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        return formatter.string(from: self)
    }
}
