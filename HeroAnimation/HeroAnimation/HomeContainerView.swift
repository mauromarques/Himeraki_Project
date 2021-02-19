//
//  HomeContainerView.swift
//  HeroAnimation
//
//  Created by Vinicius Moreira Leal on 19/02/2021.
//

import SwiftUI

//struct HomeContainerView: View {
//    @State var isPresented = false
//    @Namespace var namespace
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                withAnimation {
//                    self.isPresented.toggle()
//                }
//            }) {
//                Text("Toggle")
//            }
//            
//            SomeSourceContainer {
//                MatchedView()
//                    .matchedGeometryEffect(id: "UniqueViewID", in: namespace, properties: .frame, isSource: !isPresented)
//            }
//            
//            if isPresented {
//                SomeTargetContainer {
//                    MatchedTargetView()
//                        .matchedGeometryEffect(id: "UniqueViewID", in: namespace, properties: .frame, isSource: isPresented)
//                }
//            }
//        }
//    }
//}
