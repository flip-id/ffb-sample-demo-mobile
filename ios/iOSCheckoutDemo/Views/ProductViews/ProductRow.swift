//
//  ProductRow.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 11/04/25.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product)) {
            HStack {
                Image(systemName: product.imageURL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    
                    Text("IDR \(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {
                    cartManager.addToCart(product: product)
                }) {
                    
                }
                .padding(.trailing)
            }
        }
    }
}
