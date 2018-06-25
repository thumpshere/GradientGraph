//
//  ViewController.swift
//  demo graph
//
//  Created by Arpit on 07/04/18.
//  Copyright © 2018 Arpit. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet var vwGraph: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let graphView:GraphView = GraphView()
        self .addChildViewController(graphView)
        graphView.view.frame = CGRect.init(x: 0, y: 0, width: self.vwGraph.frame.width, height: self.vwGraph.frame.height)
        self.vwGraph .addSubview(graphView.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

