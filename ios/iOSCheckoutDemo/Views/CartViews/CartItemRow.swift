//
//  CartItemRow.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 11/04/25.
//

import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        HStack {
            Image(systemName: item.product.imageURL)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(item.product.name)
                    .font(.headline)
                Text("IDR \(item.product.price, specifier: "%.2f")")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    cartManager.removeFromCart(product: item.product)
                }) {
                    Image(systemName: "minus.circle")
                }
                
                Text("\(item.quantity)")
                    .font(.headline)
                    .frame(width: 30)
                
                Button(action: {
                    cartManager.addToCart(product: item.product)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
        }
    }
}
