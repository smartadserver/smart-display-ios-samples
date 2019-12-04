//
//  InterstitialManagerObservableObject.swift
//  SwiftUISample
//
//  Created by Loïc GIRON DIT METAZ on 02/08/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import SwiftUI
import Combine
import SASDisplayKit

// Interstitial Manager Observable Object
// ------------------------------------
//
// Smart interstitials are handled using the SASInterstitialManager class, which is inherently imperative (using a
// delegate in this case). SwiftUI works best with objects implemented using a reactive paradigm.
//
// Fortunately, Swift allows you to transform an imperative object into a reactive one by developing a small
// wrapper implementing ObservableObject.
//
// Here is a really simple implementation of an ObservableObject that hold a SASInterstitialManager.
// You will probably need to customize this class to suite your needs.
class InterstitialManagerObservableObject : NSObject, SASInterstitialManagerDelegate, ObservableObject {
    
    // Property used to send a message each time the underlying interstitial manager's status changes.
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    // A private instance of a SASInterstitialManager.
    private lazy var interstitialManager: SASInterstitialManager = {
        SASInterstitialManager(placement: placement, delegate: self)
    }()
    
    // The interstitial manager ad placement.
    let placement: SASAdPlacement
    
    // The status of the interstitial manager observable object (that represents the status of
    // the underlying SASInterstitialManager instance).
    var status: SASAdStatus {
        interstitialManager.adStatus
    }
    
    init(placement: SASAdPlacement) {
        self.placement = placement
    }

    func load() {
        // Simple interstitial loading using the interstitial manager.
        interstitialManager.load()
        
        objectWillChange.send() // The interstitial manager might have change, a message must be sent!
    }
    
    func show() {
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            // Interstitial display using the interstitial manager.
            // Since SwiftUI does not use any UIViewController, we provide the root view controller
            // to the show(from:) method.
            interstitialManager.show(from: viewController)
            
            objectWillChange.send() // The interstitial manager might have change, a message must be sent!
        }
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didLoad ad: SASAd) {
        NSLog("Interstitial did load")
        objectWillChange.send() // The interstitial manager might have change, a message must be sent!
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didFailToLoadWithError error: Error) {
        NSLog("Interstitial did fail to load with error: \(error)")
        objectWillChange.send() // The interstitial manager might have change, a message must be sent!
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didFailToShowWithError error: Error) {
        NSLog("Interstitial did fail to show with error: \(error)")
        objectWillChange.send() // The interstitial manager might have change, a message must be sent!
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didAppearFrom viewController: UIViewController) {
        NSLog("Interstitial did appear")
        objectWillChange.send() // The interstitial manager might have change, a message must be sent!
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didDisappearFrom viewController: UIViewController) {
        NSLog("Interstitial did disappear")
        objectWillChange.send() // The interstitial manager might have change, a message must be sent!
    }
    
}
