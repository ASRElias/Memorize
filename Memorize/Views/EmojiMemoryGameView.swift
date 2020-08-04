//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Elias Santa Rosa on 27/07/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(emojiMemoryGame.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)) {
                            self.emojiMemoryGame.choose(card: card)
                        }
                }
                .padding(5.0)
            }
            .padding()
            .foregroundColor(.orange)
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.emojiMemoryGame.resetGame()
                }
            }, label: { Text("New Game") })
        }
    }
    
}

struct CardView: View {
    
    private let fontScaleFactor: CGFloat = 0.7
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    @State private var animatedBonusRemaining: Double = 0
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear { self.startBonusTimeAnimation() }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                .transition(.scale)
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(emojiMemoryGame: game)
    }
    
}
