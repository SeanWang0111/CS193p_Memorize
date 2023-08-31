//
//  ArrayManager.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/26.
//

import Foundation
import SwiftUI

class ArrayManager {
    
    static let colorArr: [Color] = [.black, .blue, .brown, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red, .teal, .yellow]
    
    static let dogImageArr: [String] = ["Akita", "Beagle", "BerneseMountain", "BichonFrise", "BorderCollie", "Bulldog", "Chihuahua", "ChowChow", "Corgi", "Dachshund", "Dalmatian", "DobermanPinscher", "GermanShepherd", "GoldenRetriever", "Husky", "Labrador", "Maltese", "Papillon", "Pomeranian", "Poodle", "Pug", "Samoyed", "ShetlandSheepdog", "Shiba", "YorkshireTerrier"]
    
    static var pokerIcon: [String] {
        let suits: [String] = ["♠︎", "♣︎", "♥︎", "♦︎"]
        let numbers: [String] = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        
        return suits.flatMap { suit in
            numbers.map { number in
                "\(suit)\(number)"
            }
        }
    }
    
    static var starSignIcon: [String] {
        let stars: [String] = ["♈︎", "♉︎", "♊︎", "♋︎", "♌︎", "♍︎", "♎︎", "♏︎", "♐︎", "♑︎", "♒︎", "♓︎"]
        let genders: [String] = ["♂︎", "♀︎"]
        
        return stars.flatMap { star in
            genders.map { gender in
                "\(star) \(gender)"
            }
        }
    }
    
    static let topic: [String] = ["✈️", "♈︎ ♂︎", "♠︎A", "🐶"]
    
    static let trafficIcon: [String] = ["✈️", "🚅", "🛰️", "🚀", "🚑", "🛻", "🚝", "🚁", "🛳️", "🚤", "🚔", "🚍", "🚘", "🚖", "🚢", "🛥️", "⛵️", "🛶", "🛸", "🚂", "🚆", "🛩️", "🚈", "🚞"]
}
