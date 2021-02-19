//
//  ViewRouter.swift
//  HeroAnimation
//
//  Created by Vinicius Moreira Leal on 19/02/2021.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Screen = .home
}
