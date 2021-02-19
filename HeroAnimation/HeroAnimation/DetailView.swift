//
//  DetailView.swift
//  HeroAnimation
//
//  Created by Vinicius Moreira Leal on 19/02/2021.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    StickyHeader(content: {
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }, action: dismiss)
                    
                    // Scroll View Content Here
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CloseButton(action: dismiss)
                }
            }
        }
    }
    
    private func dismiss() {
        withAnimation {
            viewRouter.currentPage = .home
        }
    }
}

struct CloseButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                Color(.white)
                    .cornerRadius(28)
                    .frame(width: 28, height: 28)
                LineView(degrees: 45)
                LineView(degrees: -45)
            }
        })
    }
}

struct LineView: View {
    
    let degrees: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .foregroundColor(Color.red)
            .frame(width: 18, height: 3)
            .rotationEffect(Angle(degrees: degrees))
    }
}

struct StickyHeader<Content: View>: View {
    let offsetThreshold: CGFloat = 180
    let offsetThresholdRange: ClosedRange<CGFloat> = 0...250
    
    let minHeight: CGFloat
    let content: Content
    let action: () -> Void
    
    init(minHeight: CGFloat = 280, @ViewBuilder content: () -> Content, action: @escaping () -> Void) {
        self.minHeight = minHeight
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        GeometryReader { geo in
            if(geo.globalMinY <= 0) {
                content
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            } else {
                content
                    .offset(y: -evaluateThreshold(geo.globalMinY))
                    .frame(width: geo.size.width, height: geo.size.height + evaluateThreshold(geo.globalMinY))
            }
        }.frame(minHeight: minHeight)
    }
    
    private func evaluateThreshold(_ minY: CGFloat) -> CGFloat {
        if offsetThresholdRange.contains(minY) {
            return offsetThreshold
        } else if minY > offsetThresholdRange.upperBound {
            action()
            return offsetThreshold
        } else {
            return minY
        }
    }
}

extension GeometryProxy {
    var globalMinY: CGFloat {
        frame(in: .global).minY
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
