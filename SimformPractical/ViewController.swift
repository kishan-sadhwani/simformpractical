//
//  ViewController.swift
//  SimformPractical
//
//  Created by Kishan Sadhwani on 05/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let tabbar = StoryBoard.tabs.instantiateViewController(withIdentifier: "TabBarController")
        self.navigationController?.pushViewController(tabbar, animated: true)
    }


}

