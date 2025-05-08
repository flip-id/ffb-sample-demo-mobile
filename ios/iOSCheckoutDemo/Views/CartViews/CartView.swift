//
//  CartView.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 11/04/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showingCheckout = false
    
    var body: some View {
        NavigationView {
            VStack {
                if cartManager.items.isEmpty {
                    VStack {
                        Image(systemName: "cart.badge.minus")
                            .font(.system(size: 60))
                            .padding()
                            .foregroundColor(.gray)
                        Text("Your cart is empty")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(cartManager.items) { item in
                            CartItemRow(item: item)
                        }
                        
                        Section {
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                Spacer()
                                Text("IDR \(cartManager.total, specifier: "%.2f")")
                                    .font(.headline)
                            }
                        }
                    }
                    
                    Button(action: {
                        showingCheckout = true
                    }) {
                        Text("Proceed to Checkout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    .sheet(isPresented: $showingCheckout) {
                        CheckoutView()
                    }
                }
            }
            .navigationTitle("Cart")
            .toolbar {
                if !cartManager.items.isEmpty {
                    Button(action: {
                        cartManager.clearCart()
                    }) {
                        Text("Clear")
                    }
                }
            }
        }
    }
}
