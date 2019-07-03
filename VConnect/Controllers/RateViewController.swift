//
//  RateViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 7/2/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    let rateView = RateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rateView)
        view.backgroundColor = UIColor.init(hexString: "033860")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
