//
//  CheckoutView.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 11/04/25.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartManager: CartManager
    @State private var selectedPaymentMethod = 0
    @State private var isProcessing = false
    @State private var showingConfirmation = false
    @State private var showWebPayment = false
    @State private var paymentSuccessful = false
    @State private var paymentPageURL: URL?
    
    // Updated payment methods array with HPP option
    var paymentMethods = ["Flip for Business", "Card Payment"]
    
    // Generate flip payment URL with order information
    private func getPaymentPageURL() async throws -> URL {
        let url = URL(string: "https://asia-southeast2-flip-stg-pon-c820.cloudfunctions.net/flipCheckoutDemo")!
        let orderID = UUID().uuidString
        let amount = Int(cartManager.total)

        let requestBody: [String: Any] = [
            "amount": amount,
            "reference_id": orderID
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])

        let (data, _) = try await URLSession.shared.data(for: request)

        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let urlString = json["link_url"] as? String,
              let paymentURL = URL(string: urlString) else {
            throw URLError(.badServerResponse)
        }

        return paymentURL
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Shipping Information")) {
                        TextField("Full Name", text: .constant("Zaki Ibrahim"))
                        TextField("Address", text: .constant("Arcadia Green Park Tower F"))
                        TextField("City", text: .constant("South Jakarta"))
                        TextField("Zip Code", text: .constant("12501"))
                    }
                    
                    Section(header: Text("Payment Method")) {
                        Picker("Select Payment Method", selection: $selectedPaymentMethod) {
                            ForEach(0..<paymentMethods.count) { index in
                                Text(paymentMethods[index])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if selectedPaymentMethod == 0 {
                            Text("You'll be redirected to Flip Checkout secure payment page")
                                .foregroundColor(.primary)
                            Text("This is a demo payment page and is not intended for real transactions. Please do not enter or use actual payment information.").fontWeight(.thin).foregroundColor(.red)
                            
                        } else {
                            // Credit Card Fields
                            Text("Currently under maintenance")
                                .foregroundColor(.red)
                        }
                    }
                    Section(header: Text("Order Summary")) {
                        ForEach(cartManager.items) { item in
                            HStack {
                                Text(item.product.name)
                                Spacer()
                                Text("\(item.quantity) × $\(item.product.price, specifier: "%.2f")")
                            }
                        }
                        
                        HStack {
                            Text("Total")
                                .fontWeight(.bold)
                            Spacer()
                            Text("$\(cartManager.total, specifier: "%.2f")")
                                .fontWeight(.bold)
                        }
                    }
                }
                
                Button(action: {
                    if selectedPaymentMethod == 0 {
                        // Flip for Business → Use Flip Checkout
                        isProcessing = true
                        Task {
                            do {
                                let url = try await getPaymentPageURL()
                                self.paymentPageURL = url
                                self.showWebPayment = true
                            } catch {
                                print("Failed to get payment URL: \(error)")
                                // Optionally show an alert to user
                            }
                            isProcessing = false
                        }
                    } else {
                        // Other payment methods
                        processPayment()
                    }
                }) {
                    Group {
                        if isProcessing {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Complete Purchase")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(isProcessing)
                .padding()
            }
            .navigationTitle("Checkout")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showWebPayment) {
                if let url = paymentPageURL {
                    NavigationView {
                        PaymentWebView(url: url) { success in
                            self.paymentSuccessful = success
                            self.showWebPayment = false
                            
                            if success {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.showingConfirmation = true
                                }
                            }
                        }
                        .navigationBarTitle("Payment", displayMode: .inline)
                        .navigationBarItems(leading: Button("Cancel") {
                            showWebPayment = false
                        })
                    }
                } else {
                    Text("Loading payment page...")
                }
            }
            .alert(isPresented: $showingConfirmation) {
                Alert(
                    title: Text("Order Confirmed"),
                    message: Text("Your payment was successful. Thank you for your purchase!"),
                    dismissButton: .default(Text("OK")) {
                        cartManager.clearCart()
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }
    
    func processPayment() {
        isProcessing = true
        
        // Simulate payment processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isProcessing = false
            showingConfirmation = true
        }
    }
}
