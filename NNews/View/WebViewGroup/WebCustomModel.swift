//
//  WebCustomView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 20.01.22.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

class WebViewModel: ObservableObject {
    let webView: WKWebView
    var url: URL
    
    init(urlTarget: URL? = nil) {
        webView = WKWebView(frame: .zero)
        url = urlTarget ?? URL(string: "http://google.com")!
        //loadUrl()
    }
    
    func updateURL(urlNew: URL){
        url = urlNew
        loadUrl()
    }
    
    func loadUrl() {
        webView.load(URLRequest(url: url))
    }
    
    func sharedURL(){
        let sharedActivity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
                    .keyWindow?
                    .rootViewController?
                    .present(sharedActivity, animated: true)
    }
}

