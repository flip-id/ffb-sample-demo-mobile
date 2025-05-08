//
//  ProductListView.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 11/04/25.
//

import SwiftUI

struct ProductListView: View {
    let products = ProductData.products
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationView {
            List(products) { product in
                ProductRow(product: product)
                    .swipeActions {
                        Button {
                            cartManager.addToCart(product: product)
                        } label: {
                            Label("Add to Cart", systemImage: "cart.badge.plus")
                        }
                        .tint(.green)
                    }
            }
            .navigationTitle("Shop")
        }
    }
}
