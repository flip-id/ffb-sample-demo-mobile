//
//  ProductDetailView.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 11/04/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: product.imageURL)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                
                Text(product.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("IDR \(product.price, specifier: "%.2f")")
                    .font(.title)
                    .foregroundColor(.blue)
                
                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.vertical)
                
                Button(action: {
                    cartManager.addToCart(product: product)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                        Text("Add to Cart")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitle("Product Details", displayMode: .inline)
    }
}
