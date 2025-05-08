//
//  Product.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 11/04/25.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let imageURL: String
    let description: String
}

