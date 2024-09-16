//
//  SFSafariView.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import SwiftUI
import SafariServices

struct SFSafariView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

#Preview {
    SFSafariView(url: URL(string: "https://www.google.com")!)
}
