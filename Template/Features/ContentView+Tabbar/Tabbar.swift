//
//  ContentView 2.swift
//  Template
//
//  Created by Martin Kock on 23/11/2024.
//


import SwiftUI

struct Tabbar: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        UITabBar.appearance().standardAppearance = appearance
    }
    let navigationController = Injector[\.nav]
    
    var body: some View {
        /// If you want to use a TabBar, set shouldUseTabbar to true in Consts.App.shouldUseTabbar.
        if Consts.App.shouldUseTabbar {
            /// To use this TabView, make sure to add your TabBar items to the NavigationController.Destinations enum and set the shouldDisplayInTabBar property to true.
            TabView(selection: navigationController.tabSelection()) {
                ForEach(NavigationController.Destinations.allCases.filter({$0.shouldDisplayInTabBar}), id: \.self) { tabDest in
                    
                    tabDest.getTabBarView()
                        .tabItem {
                            tabDest.getIcon()
                            tabDest.getNameText()
                        }
                    
                }
                
            }
        } else {
            /// If you want to use a custom TabBar or dont want to use a TabBar, set shouldUseTabView to false and add your custom TabBar or View here.
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("\(Injector[\.test].number)")
                    .textStyle(.btn_default, color: .white)
                    .onTapGesture {
                        Injector[\.test].number += 1
                        Injector[\.nav].push(.view2)
                    }

            }
            .padding()
            .wrapInNavStack(.standard)
        }
    }
}

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 0
        // Choose with corners should be rounded
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // top left, top right
        
        // Uses `accessibilityIdentifier` in order to retrieve shadow view if already added
        if let shadowView = view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" }) {
            shadowView.frame = tabBar.frame
        } else {
            let shadowView = UIView(frame: .zero)
            shadowView.frame = tabBar.frame
            shadowView.accessibilityIdentifier = "TabBarShadow"
            shadowView.backgroundColor = UIColor.white
            shadowView.layer.cornerRadius = tabBar.layer.cornerRadius
            shadowView.layer.maskedCorners = tabBar.layer.maskedCorners
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowColor = Color.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: -18.0)
            shadowView.layer.shadowOpacity = 0.1
            shadowView.layer.shadowRadius = 20
            view.addSubview(shadowView)
            view.bringSubviewToFront(tabBar)
        }
    }
}
