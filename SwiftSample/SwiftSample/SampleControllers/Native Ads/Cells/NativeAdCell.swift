//
//  SampleNativeAdView.swift
//  SwiftSample
//
//  Created by Thomas Geley on 21/07/2016.
//  Copyright © 2016 Smart AdServer. All rights reserved.
//

import Foundation
import SASDisplayKit

class NativeAdCell: UITableViewCell {
    
    @IBOutlet weak var mediaView: SASNativeAdMediaView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var coverImageView: UIImageView?
    @IBOutlet weak var callToActionButton: UIButton?
    @IBOutlet weak var adChoicesButton: SASAdChoicesView!
    
    @IBOutlet weak var titleLeadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtitleLeadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconTopSpaceConstraint: NSLayoutConstraint!
    
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> NativeAdCell? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? NativeAdCell
    }
    
    func setIconViewHidden(_ hidden: Bool) {
        iconImageView?.isHidden = hidden
        titleLeadingSpaceConstraint.constant = hidden ? 2 : 52
    }
    
    func updateConstraintsWhenCoverAndMediaAreHidden(_ hidden: Bool) {
        iconTopSpaceConstraint.constant = hidden ? 12 : 2
        subtitleLeadingSpaceConstraint.constant = hidden ? titleLeadingSpaceConstraint.constant : 2
    }

}
