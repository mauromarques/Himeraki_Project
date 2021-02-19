//
//  HeroAnimationApp.swift
//  HeroAnimation
//
//  Created by Vinicius Moreira Leal on 19/02/2021.
//

import SwiftUI

@main
struct HeroAnimationApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewRouter)
        }
    }
}
