//
//  PaymentWebView.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 14/04/25.
//

import SwiftUI
@preconcurrency import WebKit

struct PaymentWebView: UIViewRepresentable {
    let url: URL
    var onCompletion: (Bool) -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: PaymentWebView
        
        init(_ parent: PaymentWebView) {
            self.parent = parent
        }
        
        // Detect successful payment completion
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                // Check for success or cancel URLs
                if url.absoluteString.contains("payment_success") {
                    decisionHandler(.cancel)
                    parent.onCompletion(true)
                    return
                } else if url.absoluteString.contains("payment_cancel") {
                    decisionHandler(.cancel)
                    parent.onCompletion(false)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
}
