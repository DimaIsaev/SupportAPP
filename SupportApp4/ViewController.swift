//
//  ViewController.swift
//  SupportApp4
//
//  Created by Дмитрий Исаев on 04.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var builder = {
        return ViewBulder(controller: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main
        builder.setCircle()
        builder.setImage()
        builder.setText()
        builder.setVariants()
        builder.addButton()
        
    }


}

