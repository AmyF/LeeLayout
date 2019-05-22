//
//  ViewController.swift
//  LeeLayout
//
//  Created by 840382477@qq.com on 05/22/2019.
//  Copyright (c) 2019 840382477@qq.com. All rights reserved.
//

import UIKit
import LeeLayout

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redView = UIView()
        redView.backgroundColor = .red
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        view.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(greenView)
        
        redView.layoutManage
            .setEdges(insets: .init(top: 20, left: 20, bottom: 20, right: 20))
            .over()
        blueView.layoutManage
            .leading(equalTo: redView.leadingAnchor, constant: 20)
            .top(equalTo: redView.topAnchor, constant: 20)
            .width(30)
            .height(30)
            .end()
        _ = greenView.layoutManage.setCenter().width(40).height(80)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

