//
//  ViewController.swift
//  JNInfrastructure
//
//  Created by Renju Jiang on 2019/1/10.
//  Copyright © 2019 jiangrenju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var indexLabel: UILabel!
    
    
    private lazy var throttler: JNThrottler = JNThrottler(seconds: 2.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        throttler.throttle {
            print("touches")
        }
    }


}

