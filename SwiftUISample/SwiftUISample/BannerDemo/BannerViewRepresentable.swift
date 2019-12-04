//
//  BannerViewRepresentable.swift
//  SwiftUISample
//
//  Created by Loïc GIRON DIT METAZ on 12/09/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import SwiftUI
import SASDisplayKit

// Banner View Representable
// -------------------------
//
// UIView cannot be integrated directly into a SwiftUI layout. Because of this limitation, you must
// use a UIViewRepresentable that wrap the SASBannerView instance.
//
// Here is a really simple implementation of a UIViewRepresentable that hold a SASBannerView.
// You will probably need to customize this class to suite your needs.
struct BannerViewRepresentable: UIViewRepresentable {
    
    // The ad placement is the only public parameter of the struct.
    let placement: SASAdPlacement
    
    // A private instance of SASBannerView.
    // No need to specify a valid frame here as the view will be automatically resize by SwiftUI.
    private let bannerView = SASBannerView(frame: .zero, loader: .activityIndicatorStyleBlack)
    
    // The makeUIView(context:) method is used to initialize the banner view since its already created.
    func makeUIView(context: Context) -> SASBannerView {
        
        // Don't forget to add a modalParentViewController to the banner other it will not be able
        // to handle clicks and expand formats!
        bannerView.modalParentViewController = UIApplication.shared.windows.first?.rootViewController
        
        // We load the banner as soon as created.
        load()
        
        // Then the initialized banner view must be returned.
        return bannerView
    }

    func updateUIView(_ bannerView: SASBannerView, context: Context) {
        // nothing to do here
    }
    
    // Public API to load or reload the ad from the SwiftUI layout (in our case, from the 'Reload' button).
    func load() {
        bannerView.load(with: placement)
    }
    
}
