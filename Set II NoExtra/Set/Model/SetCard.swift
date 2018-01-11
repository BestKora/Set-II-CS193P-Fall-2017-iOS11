//
//  SetCard.swift
//  Set
//
//  Created by Tatiana Kornilova on 12/31/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import Foundation

struct SetCard: Equatable, CustomStringConvertible {
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
        return (
            (lhs.number == rhs.number) &&
            (lhs.color == rhs.color) &&
            (lhs.shape == rhs.shape) &&
            (lhs.fill == rhs.fill)
        )
    }
    
    let number: Variant // number - 1, 2, 3
    let color: Variant  // color  - 1, 2, 3 (например, red, green, purple)
    let shape: Variant  // symbol - 1, 2, 3 (например, diamond, squiggle, oval)
    let fill: Variant   // fill   - 1, 2, 3 (например, solid, striped, open)
   
    var description: String {return "\(number)-\(color)-\(shape)-\(fill)"}
    
    enum Variant: Int, CustomStringConvertible  {
        case v1 = 1
        case v2
        case v3
        
        static var all: [Variant]{return [.v1, .v2, .v3]}
        var description: String {return String(self.rawValue)}
        var idx: Int {return (self.rawValue - 1)}
    }
    
    static func isSet(cards: [SetCard]) -> Bool {
        guard cards.count == 3 else {return false}
        let sum = [
        cards.reduce(0, { $0 + $1.number.rawValue}),
        cards.reduce(0, { $0 + $1.color.rawValue}),
        cards.reduce(0, { $0 + $1.shape.rawValue}),
        cards.reduce(0, { $0 + $1.fill.rawValue})
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
}
