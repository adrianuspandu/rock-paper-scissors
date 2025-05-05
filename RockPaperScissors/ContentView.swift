//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by student on 28.03.25.
//

import SwiftUI

struct ContentView: View {
    private let availableMoves = ["🗿", "📄", "✂️"]
    @State private var opponentHand = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var alertIsShown = false
    @State private var playerScore = 0
    @State private var playerAttempts = 0
    @State private var alertMessage = ""
    
    
    struct MoveButton: View {
        let move: String
        let action: () -> Void
        
        var body: some View {
            Button(move) {
                action()
            }
            .font(.largeTitle)
            .padding(20)
            .background(.indigo)
            .clipShape(.rect(cornerRadius: 10))
        }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Player‘s Score: \(playerScore)/\(playerAttempts)")
                    .font(.title3)
                    .bold()
                
                Text(availableMoves[opponentHand])
                    .font(.system(size: 96))
                    .padding(20)
                
                Text("You should")
                Text(shouldWin ? "Win" : "Lose")
                    .font(.largeTitle.weight(.bold))
                
                Spacer()
                
                HStack{
                    ForEach(availableMoves, id: \.self) { move in
                        MoveButton(move: move) {
                            checkAnswer(move: move)
                        }
                    }
                }
            }
            .padding(.vertical, 80)
            .alert(alertMessage, isPresented: $alertIsShown){
                Button("Ok") {
                    loadNewRound()
                }
            }
        }
    }
    
    func checkAnswer(move: String) {
        let correctMove = getCorrectMove(for: opponentHand, shouldWin: shouldWin)
        
        if move == correctMove {
            playerScore += 1
            alertMessage = "Correct 🎉"
        } else {
            alertMessage = "Wrong 😭"
        }
        
        playerAttempts += 1
        alertIsShown.toggle()
    }
    
    func getCorrectMove(for opponentMove: Int, shouldWin: Bool) -> String {
        switch availableMoves[opponentMove] {
        case "🗿": return shouldWin ? "📄" : "✂️"
        case "📄": return shouldWin ? "✂️" : "🗿"
        case "✂️": return shouldWin ? "🗿" : "📄"
        default: return "🗿"
        }
    }
    
    func loadNewRound() {
        opponentHand = Int.random(in: 0...2)
        shouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
