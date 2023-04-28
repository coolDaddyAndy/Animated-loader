//
//  ViewController.swift
//  Animated loader
//
//  Created by Andrei Sushkou on 28.04.23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .cyan
        button.tintColor = .black
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var imageView = MainImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(downloadButton)
        view.addSubview(imageView)
        constraintsSetup()
    }

    @objc func downloadButtonTapped() {
        imageView.fetchImage()
    }
    
    private func constraintsSetup() {
        NSLayoutConstraint.activate([
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            downloadButton.heightAnchor.constraint(equalToConstant: 80),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }

}

