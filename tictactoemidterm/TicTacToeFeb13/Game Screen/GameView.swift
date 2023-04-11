//
//  GameView.swift
//  TicTacToeFeb13
//
//  Created by Rajiv Mukherjee on 2/15/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game:GameService
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy{ $0 == false }{
                Text("Select a player to start")
            }
            
            HStack{
                Button(game.player1.name){
                    game.player1.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                
                
                Button(game.player2.name){
                    game.player2.isCurrent = true
                    if game.gameType == .bot{
                        Task{
                            await game.deviceMove()
                        }//end of task
                    }//end of bot logic
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))
                
            }//end of hstack
            .disabled(game.gameStarted)
            
            //create a gameboard
            VStack{
                HStack{
                    ForEach(0...3, id:\.self){
                        index in SquareView(index: index)
                    }
                }//end of first HStack
                
                HStack{
                    ForEach(4...7, id:\.self){
                        index in SquareView(index: index)
                    }
                }//end of second HStack
                
                HStack{
                    ForEach(8...11, id:\.self){
                        index in SquareView(index: index)
                    }
                }//end of third HStack
                HStack{
                    ForEach(12...15, id:\.self){
                        index in SquareView(index: index)
                    }
                }//end of fourth HStack
                
            }//end of VStack
            .disabled(game.boardDisabled)
            .overlay{
                if game.isThinking{
                    VStack{
                        Text("Thinking...")
                            .foregroundColor(Color(.systemBackground))
                            .background(Rectangle().fill(Color.primary))
                        ProgressView()
                    }
                }//emnd of if
            }
            
            VStack{
                //Result layout of the UI
                if game.gameOver{
                    Text("Game Over")
                    if game.possibleMoves.isEmpty{
                        Text("It's a draw!")
                    }//end of isempty check
                    else{
                        Text("\(game.currentPlayer.name) wins")
                    }//end of else
                    Button("New Game") {
                        game.reset()
                    }//end of button
                    .buttonStyle(.borderedProminent)
                }//end of gameOver check
            }//end of VStack
            .font(.largeTitle)
            
            Spacer()
            
        }//end of vstack
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("End Game") {
                    dismiss()
                }
                .buttonStyle(.bordered)
            }//end toolbaritem
        }//end toolbar
        .navigationTitle("Cross Over")
        .onAppear{game.reset()}
        .inNavigationStack()
    }//end View
}//end struct

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        .environmentObject(GameService())
    }
}//end of gameview struct

struct PlayerButtonStyle:ButtonStyle{
    let isCurrent:Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(isCurrent ? Color.green:Color.gray))
            .foregroundColor(.white)
            
    }
}
