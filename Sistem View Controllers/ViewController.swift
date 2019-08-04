//
//  ViewController.swift
//  Sistem View Controllers
//
//  Created by  Джон Костанов on 04/08/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//
import SafariServices
import UIKit

class ViewController: UIViewController {
    
    // MARH:- Outlets
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(with: view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(with: size)
        
    }
    
    // MARK: - UI Methods
    func updateUI(with size: CGSize) {
        let isVertical = size.width < size.height
        stackView.axis = isVertical ? .vertical : .horizontal
    }
    
    // MARK: - Actions
    @IBAction func shareButtonPressed(_ sender: UIButton ) {
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true)
    }
    
    @IBAction func safariButtonPressed(_ sender: UIButton ) {
        let url = URL(string: "http://jw.org")!
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
        
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton ) {
        print(#line, #function)
    }
    
    @IBAction func emailButtonPressed(_ sender: UIButton ) {
        print(#line, #function)
    }
}

