//
//  Array.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/25.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}
