//
//  Animation.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/25.
//

import Foundation
import SwiftUI

extension Animation {
    
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}
