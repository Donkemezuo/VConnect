//
//  SpecialistProfileHeaderView.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/2/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class SpecialistProfileHeaderView: UIView {
    @IBOutlet var specialistProfileHeaderView: UIView!

    @IBOutlet weak var specialistCoverImageView: UIImageView!
    
    @IBOutlet weak var specialistProfileImageView: UIImageView!
    
    @IBOutlet weak var specialistNameLabel: UILabel!
    
    @IBOutlet weak var specializationLabel: UILabel!
    
    
    @IBOutlet weak var numberOfExperienceLabel: UILabel!
    
    @IBOutlet weak var specialistLocationLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    
    @IBOutlet weak var aboutSpecialistTextView: UITextView!
    
    
    @IBOutlet weak var specialistSegmentedView: UISegmentedControl!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("specialistProfileHeaderView", owner: self, options: nil)
        addSubview(specialistProfileHeaderView)
        specialistProfileHeaderView.frame = bounds
    }
    
    
    
    
}
