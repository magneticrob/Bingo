//
//  ViewController.swift
//  Bingo
//
//  Created by Rob Baker on 04/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Game(input: Input.input).start()
    }


}

