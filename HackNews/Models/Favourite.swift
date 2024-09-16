//
//  Favorites.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import Foundation
import SwiftData

@Model
class Favourite {
    
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}
