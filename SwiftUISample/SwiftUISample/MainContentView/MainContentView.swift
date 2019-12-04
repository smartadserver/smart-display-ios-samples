//
//  MainContentView.swift
//  SwiftUISample
//
//  Created by Loïc GIRON DIT METAZ on 02/08/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import SwiftUI

struct MainContentView: View {
    
    struct Demo : Identifiable {
        let id = UUID()
        let label: String
        let view: AnyView
    }
    
    let demos = [
        
        // Note:
        // This sample only shows simple integration cases of banners & interstitials. For more complex
        // integration, check the SwiftSample project.
        
        Demo(label: "Banner", view: AnyView(BannerDemoView())),
        Demo(label: "Interstitial", view: AnyView(InterstitialDemoView())),
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("CHOOSE A SAMPLE:").padding(.top, 20),
                        footer: Text("This sample demonstrates how to implement the Smart AdServer SDK in applications that use SwiftUI.\n\nFor applications that use regular Swift (or for more complex integration cases), check the SwiftSample project.")
                            .padding(.top)
                            .lineLimit(nil)) {
                                
                    ForEach(demos) { demo in
                        NavigationLink(destination: demo.view) {
                            Text(demo.label)
                        }
                    }
                                
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Smart Sample"), displayMode: .inline)
        }
    }
    
}

#if DEBUG
struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
#endif
