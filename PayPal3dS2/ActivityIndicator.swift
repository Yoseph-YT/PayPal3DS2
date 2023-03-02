//
//  ActivityIndicator.swift
//  PayPal3dS2
//
//  Created by Yoseph Tilahun on 1/20/23.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    var color: UIColor
    //ActivityIndicator(isAnimating: $isShowing, style: .large)
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.color = color
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
