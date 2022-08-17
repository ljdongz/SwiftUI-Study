//
//  ContentView.swift
//  MemoryGame
//
//  Created by 이정동 on 2022/07/13.
//

import SwiftUI

struct GameView: View {
    var prefix: String
    @ObservedObject var game = GameModel()
    @Environment(\.presentationMode) var present
    @State var showsRestartAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Text("Memory Game")
                Spacer()
                Text("Flips: \(game.flips)")
            }
            .padding(.horizontal)
            
            GridStack(rows: GameModel.rows, columns: GameModel.cols){ row, column in
                CardView(prefix: prefix, card: game.card(row: row, col: column))
                    .gesture(
                        TapGesture().onEnded{
                            game.open(row: row, col: column)
                            if game.over {
                                showsRestartAlert = true
                            }
                        }
                    )
            }
            .aspectRatio(CGSize(width: GameModel.cols, height: GameModel.rows), contentMode: .fit)
            Spacer()
            HStack{
                Spacer()
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .stroke(lineWidth: 2.0)
                        )
                }
                Spacer()
                Button {
                    showsRestartAlert = true
                } label: {
                    Text("Restart")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .stroke(lineWidth: 2.0)
                        )
                }
                Spacer()
            }
            Spacer()
        }
        .background(
            LinearGradient(colors: [
                .white, .yellow.opacity(0.5)
            ], startPoint: .topLeading, endPoint: .bottomTrailing))
        .alert(isPresented: $showsRestartAlert){
            Alert(
                title: Text("Restart?"),
                message: Text("Do you want to restart the game?"),
                primaryButton: .cancel(),
                secondaryButton: .default(Text("Restart")){
                    game.start()
                })
        }
        .navigationBarHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(prefix: "t")
    }
}
