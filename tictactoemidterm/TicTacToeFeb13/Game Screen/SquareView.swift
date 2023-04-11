//
//  SquareView.swift
//  TicTacToeFeb13
//
//  Created by Rajiv Mukherjee on 2/26/23.
//

import SwiftUI

struct SquareView: View {
    //to access the GameService class in this view
    @EnvironmentObject var game:GameService
    let index: Int
    
    var body: some View {
        Button{
            if !game.isThinking{
                game.makeMove(at: index)
            }// end of if
            
        } label: {
            game.gameBoard[index].image
                .resizable()
                .frame(width:50, height: 50)
                .border(.primary)
        }
        .disabled(game.gameBoard[index].player != nil)
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(index: 1)
            .environmentObject(GameService())
    }
}
