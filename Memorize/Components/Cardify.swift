//
//  Cardify.swift
//  Memorize
//
//  Created by Elias Santa Rosa on 03/08/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: Double {
        
        get { return rotation }
        set { rotation = newValue }
        
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0: 180
    }
    
    func body(content: Content) -> some View {
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        
    }
    
}
