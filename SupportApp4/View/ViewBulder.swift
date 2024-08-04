//
//  ViewBulder.swift
//  SupportApp4
//
//  Created by Дмитрий Исаев on 04.08.2024.
//

import UIKit

enum PayVariant: Int, CaseIterable {
    case small = 100
    case middle = 300
    case big = 500
}

class ViewBulder {
    
    private let manager = ViewManager.shared
    private lazy var imageView = UIImageView()
    private var titleStack = UIStackView()
    
    var controller: UIViewController
    var view: UIView
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    func setCircle() {
        let firstCircle = manager.createCircle(frame: CGRect(x: view.frame.width - 74, y: -28, width: 100, height: 100))
        let secondCircle = manager.createCircle(frame: CGRect(x: 83, y: 100, width: 67, height: 67))
        let thirdCircle = manager.createCircle(frame: CGRect(x: view.frame.width - 206, y: 216, width: 268, height: 268))
        let fourthCircle = manager.createCircle(frame: CGRect(x: 83, y: view.frame.height - 328, width: 56, height: 56))
        let fifthCircle = manager.createCircle(frame: CGRect(x: 269, y: view.frame.height - 217, width: 97, height: 97))
        let sixthCircle = manager.createCircle(frame: CGRect(x: -45, y: view.frame.height - 100, width: 150, height: 150))
        
        [firstCircle, secondCircle, thirdCircle, fourthCircle, fifthCircle, sixthCircle].forEach { item in
            view.addSubview(item)
        }
    }
    
    func setImage() {
        imageView = UIImageView()
        imageView.image = .baner
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 267).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 267).isActive = true
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -61)
        ])
    }
    
    func setText() {
        titleStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 10
            stack.alignment = .leading
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let topTitle = manager.createTitle(size: 30, weight: .bold, text: "Приложение и все его функции бесплатные")
        let bottomTitle = manager.createTitle(size: 16, weight: .regular, text: "все средства идут на улучшение и поддержку проекта")
        
        titleStack.addArrangedSubview(topTitle)
        titleStack.addArrangedSubview(bottomTitle)
        
        view.addSubview(titleStack)
        
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 37),
            titleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func selectVariant(sender: UIGestureRecognizer) {
        PayVariant.allCases.forEach { variant in
            if let selectView = self.view.viewWithTag(variant.rawValue) {
                selectView.layer.borderColor = .none
                selectView.layer.borderWidth = 0
            }
            
            if let selectTag = sender.view?.tag {
                if let selectedView = self.view.viewWithTag(selectTag) {
                    selectedView.layer.borderColor = UIColor.white.cgColor
                    selectedView.layer.borderWidth = 3
                }
            }
        }
    }
    
   private func createPayVariant(variant: PayVariant) -> UIView {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVariant (sender: )))
       
        let payView = UIView()
        payView.layer.cornerRadius = 21
        payView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        payView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        payView.clipsToBounds = true
        payView.tag = variant.rawValue
        payView.addGestureRecognizer(tapGesture)
        
        switch variant {
        case .small:
            payView.backgroundColor = .orangeColorCostom
            payView.layer.borderWidth = 3
            payView.layer.borderColor = UIColor.white.cgColor
        case .middle:
            payView.backgroundColor = .pinkColorCostom
        case .big:
            payView.backgroundColor = .darkGreen
        }
        
        let titleStack = UIStackView()
        titleStack.axis = .vertical
        titleStack.spacing = 0
        titleStack.alignment = .center
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        let topTitle = manager.createTitle(size: 31, weight: .bold, text: "\(variant.rawValue)")
        let bottomTitle = manager.createTitle(size: 16, weight: .light, text: "рублей")
        
        titleStack.addArrangedSubview(topTitle)
        titleStack.addArrangedSubview(bottomTitle)
        
        payView.addSubview(titleStack)
        
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: payView.topAnchor, constant: 23),
            titleStack.bottomAnchor.constraint(equalTo: payView.bottomAnchor, constant: -23),
            titleStack.leadingAnchor.constraint(equalTo: payView.leadingAnchor, constant: 18),
            titleStack.trailingAnchor.constraint(equalTo: payView.trailingAnchor, constant: -18)
        ])
        
        return payView
    }
    
    func setVariants() {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        PayVariant.allCases.forEach { variant in
            hStack.addArrangedSubview(createPayVariant(variant: variant))
        }
        
        view.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: 60),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func addButton() {
        let button = UIButton()
        button.setTitle("поддержать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .darkGreen
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
