//
//  ViewManager.swift
//  SupportApp4
//
//  Created by Дмитрий Исаев on 04.08.2024.
//

import UIKit

class ViewManager {
    
    static let shared = ViewManager()
    private init () {}
    
    func createCircle(frame: CGRect) -> UIView {
        let circle = UIView()
        circle.backgroundColor = .circle
        circle.frame = frame
        circle.layer.cornerRadius = frame.width/2
        return circle
    }
    
    func createTitle(size: CGFloat, weight: UIFont.Weight, text: String) -> UILabel {
        let title = UILabel()
        title.text = text
        title.font = UIFont.systemFont(ofSize: size, weight: weight)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        return title
    }
}
