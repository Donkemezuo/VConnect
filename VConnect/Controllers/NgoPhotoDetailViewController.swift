//
//  NgoPhotoDetailViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 8/14/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NgoPhotoDetailViewController: UIViewController {
    private var ngoPhotoDetailsView = NGOPhotoDetailView()
    private var ngoImage: NGOImages!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ngoPhotoDetailsView)
         view.backgroundColor = UIColor.init(hexString: "0072B1")
        //ngoPhotoDetailsView.disPlayNgoImage(withNGOImage: ngoImage)
        displayNgoImage()
    }
    
    init(ngoImage: NGOImages) {
        super.init(nibName: nil, bundle: nil)
        self.ngoImage = ngoImage
        dump(ngoImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    private func displayNgoImage(){
        ImageHelper.fetchImage(urlString: ngoImage.pictureUrl) { (error, image) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                self.ngoPhotoDetailsView.ngoImageView.image = image
            }
        }
        ngoPhotoDetailsView.locationLabel.text = ngoImage.location
        ngoPhotoDetailsView.imageCaption.text =
            ngoImage.imageCaption
    }
}
