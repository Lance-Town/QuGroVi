//
//  File.swift
//  QuGroVi
//
//  Created by Lance Townsend on 4/3/22.
//

import SwiftUI


struct Item {
    let barCode: String
    var itemCount: Int = 1
    
//    init(product: String, type: String) {
//        self.product = product
//        self.type = type
//    }
    
    static let exampleOne = Item(barCode: "009758345763")
    static let exampleTwo = Item(barCode: "0011118743")
    static let exampleThree = Item(barCode: "008742315471")
    static let exampleFour = Item(barCode: "009857463728")
    static let exampleFive = Item(barCode: "008475648321")
}
