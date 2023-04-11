//
//  GameSquare.swift
//  TicTacToeFeb13
//
//  Created by Rajiv Mukherjee on 2/22/23.
//

import SwiftUI

struct GameSquare{
    var id:Int //to track tiles 1 to 9
    var player:Player?
    var image:Image{
        if let player = player{
            return player.gamePiece.image
        }
        else{
            return Image("none")
        }
    }//end of Image
    
    static var reset:[GameSquare]{
        var squares=[GameSquare]()
        for index in 1...16{
            squares.append(GameSquare(id: index))
        }
        return squares
    }
    
}//end of struct
