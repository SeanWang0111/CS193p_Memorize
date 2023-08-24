//
//  GifImage.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/24.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url: URL = Bundle.main.url(forResource: name, withExtension: "gif"),
              let data: Data = try? Data(contentsOf: url) else { return WKWebView() }
        
        let webView = WKWebView()
        webView.load(data,
                     mimeType: "image/gif",
                     characterEncodingName: "UTF-8",
                     baseURL: url.deletingLastPathComponent())
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage(name: "BIRD")
    }
}
