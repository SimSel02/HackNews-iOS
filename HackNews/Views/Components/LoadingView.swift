//
//  LoadingView.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import SwiftUI

struct LoadingView: View {
    
    @State var degreesRotating = 0.0
    
    var body: some View {
        VStack {
            rotatingImage
            Text("Hold tight!")
                .font(.title)
                .bold()
            Text("News are getting ready for you!")
        }
    }
}

#Preview {
    LoadingView()
}

extension LoadingView {
    
    private var rotatingImage: some View {
        Image(systemName: "newspaper.circle.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.red)
            .rotationEffect(.degrees(degreesRotating))
            .onAppear {
                withAnimation(.linear(duration: 1)
                    .speed(0.1).repeatForever(autoreverses: false)) {
                        degreesRotating = 360.0
                    }
            }
    }
}
