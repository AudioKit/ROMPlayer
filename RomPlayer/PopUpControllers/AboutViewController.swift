//
//  AboutViewController.swift
//  ROM Player
//
//  Created by Matthew Fecher on 7/24/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func audioKitPressed(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/AudioKit/AudioKit/graphs/contributors") {
            UIApplication.shared.open(url)
        }
    }
    
}
