//
//  SwiftUIView.swift
//  
//
//  Created by Semen Stepanov on 13.04.22.
//

import SwiftUI

public struct LikeButton: View {
    
    @State private var opacity = 0.0
    @State private var scale = 1.0
    @Binding public var isLiked: Bool
    
    public init(isLiked: Binding<Bool>) {
            self._isLiked = isLiked
    }
    
    public var body: some View {
        ZStack{
            Group {
                Image(systemName: "heart.fill")
                    .opacity(isLiked ? 1 : 0.2)
                    .animation(.easeOut, value: self.isLiked)
            }
            .imageScale(.large)
            .overlay(
                Group {
                    DotsView(count: 7, radius: 20, speed: 0.1, scale: self.isLiked ? 0.1 : 0.65)
                    DotsView(count: 7, radius: 25, speed: 0.1, scale: self.isLiked ? 0.1 : 0.2)
                        .rotationEffect(Angle(degrees: 25.7))
                }
                .opacity(self.opacity)
            )
            
        }
        .onTapGesture {
            self.isLiked.toggle()
        }
        .onChange(of: self.isLiked) { isLiked in
            self.scale = 1.0
            if isLiked {
                withAnimation(.linear(duration: 0.2)) {
                    self.scale = 1.2
                    self.opacity = 1.0
                }
                withAnimation(.linear(duration: 0.1).delay(0.2)) {
                    self.opacity = 0
                }
                withAnimation(.linear(duration: 0.2).delay(0.2)) {
                    self.scale = 1
                }
            }
            if !isLiked {
                withAnimation(.linear(duration: 0.2)) {
                    self.scale = 0.5
                }
                withAnimation(.linear(duration: 0.2).delay(0.2)) {
                    self.scale = 1
                }
            }
        }
        .scaleEffect(self.scale)
        .foregroundColor(self.isLiked ? .red : .secondary)
    }
}

#if DEBUG
    struct LikeButtonExampleView: View {
        @State var isLiked = false

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Text("Lorem Ipsum")
                        .font(.headline)
                }
                Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
                LikeButton(isLiked: $isLiked)
                Spacer()
            }
            .padding()
        }
    }

    struct LikeButtonExampleView_Previews: PreviewProvider {
        static var previews: some View {
            LikeButtonExampleView()
        }
    }
#endif
