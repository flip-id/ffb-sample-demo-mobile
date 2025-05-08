//
//  ContentView.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 14/04/25.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Products")
                }
            
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .badge(cartManager.itemCount > 0 ? cartManager.itemCount : 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager())
    }
}
