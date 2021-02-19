//
//  HomeView.swift
//  HeroAnimation
//
//  Created by Vinicius Moreira Leal on 19/02/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0...5, id: \.self) { index in
                    ChallengeView()
                        .onTapGesture {
                            withAnimation {
                                viewRouter.currentPage = .detail
                            }
                        }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .shadow(radius: 5)
            }
        }
    }
}

struct ChallengeView: View {
    var body: some View {
        Image("p1")
            .resizable()
            .frame(height: 187)
            .cornerRadius(15.0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
