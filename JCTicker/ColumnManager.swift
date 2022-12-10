//
//  ColumnManager.swift
//  JCTicker
//
//  Created by zexi chen on 2022-12-09.
//

import Foundation

class ColumnManager {
    
    func targetCol(input: String) -> [Character] {
        guard input.isNumber else {
            return []
        }
        
        return Array(input)
    }
    
    
    
    
}
