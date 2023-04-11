//
//  ViewModifier.swift
//  TicTacToeFeb13
//
//  Created by Rajiv Mukherjee on 2/15/23.
//

import SwiftUI

struct NavStackContainer:ViewModifier{
    
    func body(content: Content) -> some View {
        if #available(iOS 16, *){
            NavigationStack{
                content
            }
        } else {
            NavigationView{
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

extension View{
    public func inNavigationStack()->some View{
        return self.modifier(NavStackContainer())
    }
}
