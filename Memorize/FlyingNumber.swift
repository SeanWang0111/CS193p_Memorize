//
//  FlyingNumber.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/21.
//

import SwiftUI

struct FlyingNumber: View {
    
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text("\(number)")
                .font(.largeTitle)
        }
    }
}

struct FlyingNumber_Previews: PreviewProvider {
    static var previews: some View {
        FlyingNumber(number: 5)
    }
}
