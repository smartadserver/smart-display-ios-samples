//
//  BannerDemoView.swift
//  SwiftUISample
//
//  Created by Loïc GIRON DIT METAZ on 02/08/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import SwiftUI
import SASDisplayKit

struct BannerDemoView: View {
    
    // Banner View Representable
    // -------------------------
    //
    // UIView cannot be integrated directly into a SwiftUI layout. Because of this limitation, you must
    // use a UIViewRepresentable that wrap the SASBannerView instance.
    //
    // Check BannerViewRepresentable.swift for more info on how this object is implemented.
    //
    // You can also find more info in Apple's official documentation:
    // https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
    
    let bannerView = BannerViewRepresentable(placement: SASAdPlacement(siteId: Constants.siteID, pageId: Constants.bannerPageID, formatId: Constants.bannerFormatID))
    
    var body: some View {
        VStack {
            // The banner view representable can be added to the SwiftUI body and used like any
            // other SwiftUI view (for instance, we can set a frame using the dedicated SwiftUI
            // modifier).
            bannerView
                .frame(width: nil, height: 50, alignment: .top)
            
            Spacer()
            
            Text("Banner (click on 'Reload' to load a new banner and release the old one)")
                .lineLimit(nil)
                .padding()
            
            Spacer()
            
            Button(action: bannerView.load) {
                 // The 'Reload' button triggers a reloading of the banner view.
                Text("Reload".localizedUppercase)
                    .frame(width: 100.0, height: nil, alignment: .center)
                    .padding()
            }
            
            Spacer()
            
            Text("See implementation in BannerDemoView")
                .font(.footnote)
                .padding()
            
        }
    }
    
}

#if DEBUG
struct BannerDemoView_Previews: PreviewProvider {
    static var previews: some View {
        BannerDemoView()
    }
}
#endif
