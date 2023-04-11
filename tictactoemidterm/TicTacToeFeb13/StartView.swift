//
//  ContentView.swift
//  TicTacToeFeb13
//
//  Created by Rajiv Mukherjee on 2/13/23.
//

import SwiftUI

struct StartView: View {
    //state properties: @State
    @State private var gameType:GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus:Bool
    @State private var startGame = false
    @EnvironmentObject var game:GameService
    
    var body: some View {
        VStack {
            
            Picker("Select Game",selection: $gameType) {
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two sharing device").tag(GameType.single)
                Text("Challenge your device").tag(GameType.bot)
                Text("Challenge a friend").tag(GameType.peer)
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10,style: .continuous).stroke(style: StrokeStyle(lineWidth: 2)).accentColor(.primary))
            
            Text(gameType.description)
                .padding()
            
            //vstack to hold our text field asking for the name
            //how many text field depends upon the type of game we play
            VStack{
                switch gameType {
                case .single:
                    TextField("Your Name", text: $yourName)
                    TextField("Opponent Name", text: $opponentName)
                    
                case .bot:
                    TextField("Your Name",  text: $yourName)
                    
                case .peer:
                    EmptyView()
                    
                case .undetermined:
                    EmptyView()
                }//end of switch
            }//end of vstack for names
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width:350)
            
            if gameType != .peer{
                Button("Start Game"){
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus=false
                    startGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    gameType == .undetermined ||
                    gameType == .bot && yourName.isEmpty ||
                    gameType == .single && (yourName.isEmpty || opponentName.isEmpty)
                )
                Image("LightModeWelcome")
            }
      Spacer()
            
        }//end of vstack
        .padding()
        .fullScreenCover(isPresented: $startGame){
            GameView()
        }
        .navigationTitle("Cross Over")
        .inNavigationStack()
    }//end of body
}//end of struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(GameService())
    }
}
