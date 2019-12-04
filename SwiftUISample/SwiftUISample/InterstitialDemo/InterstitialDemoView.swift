//
//  InterstitialDemoView.swift
//  SwiftUISample
//
//  Created by Loïc GIRON DIT METAZ on 02/08/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import SwiftUI
import Combine
import SASDisplayKit

struct InterstitialDemoView: View {
    
    // Interstitial Manager Observable Object
    // ------------------------------------
    //
    // Smart interstitials are handled using the SASInterstitialManager class, which is inherently imperative (using a
    // delegate in this case). SwiftUI works best with objects implemented using a reactive paradigm.
    //
    // Fortunately, Swift allows you to transform an imperative object into a reactive one by developing a small
    // wrapper implementing ObservableObject.
    //
    // Check InterstitialManagerObservableObject.swift for more info on how this object is implemented.
    //
    // You can also find more info in Apple's official documentation:
    // https://developer.apple.com/documentation/combine/observableobject
    @ObservedObject var interstitialManager = InterstitialManagerObservableObject(placement: SASAdPlacement(testAd: .interstitialMRAID))
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Interstitial, click on 'Load Ad' to load an interstitial and 'Show Ad' to show it…")
                .lineLimit(nil)
                .padding()
            
            Spacer()
            
            Button(action: interstitialManager.load) { // The 'Load Ad' button triggers a loading on the interstitial manager.
                Text("Load Ad".localizedUppercase)
                    .frame(width: 100.0, height: nil, alignment: .center)
                    .padding()
            }
            .padding(.bottom, 25.0)
            .disabled(interstitialManager.status != .notAvailable && interstitialManager.status != .expired) // The button is displayed depending on the ad availability status, thanks to the bindable object.
            
            Button(action: interstitialManager.show) { // The 'Show Ad' button triggers an interstitial display on the interstitial manager.
                Text("Show Ad".localizedUppercase)
                    .frame(width: 100.0, height: nil, alignment: .center)
                    .padding()
            }
            .padding(.bottom, 25.0)
            .disabled(interstitialManager.status != .ready) // The button is displayed depending on the ad availability status, thanks to the bindable object.
            
            Spacer()
            
            Text("See implementation in InterstitialDemoView")
                .font(.footnote)
                .padding()
        }
    }
    
}

#if DEBUG
struct InterstitialDemoView_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialDemoView()
    }
}
#endif
