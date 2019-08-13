//
//  ViewController.swift
//  Sistem View Controllers
//
//  Created by  Джон Костанов on 04/08/2019.
//  Copyright © 2019 John Kostanov. All rights reserved.
//
import MessageUI
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
    
    // MARK: - Methods
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - Actions
    @IBAction func shareButtonPressed(_ sender: UIButton ) {
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true)
    }
    
    @IBAction func safariButtonPressed(_ sender: UIButton ) {
        let url = URL(string: "http://apple.com")!
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
        
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton ) {
        let alert = UIAlertController(title: "Please Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            alert.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alert.addAction(photoLibraryAction)
            
        }
        
        alert.popoverPresentationController?.sourceView = sender
        
        present(alert, animated: true)
    }
    
    @IBAction func emailButtonPressed(_ sender: UIButton ) {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["support@learnSwift.ru"])
        mailComposer.setSubject("Ошибка \(Data())")
        mailComposer.setMessageBody("Пожалуйста, помогите С Message Compposer'ом", isHTML: false)
        
        present(mailComposer, animated: true)
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        guard MFMessageComposeViewController.canSendText() else { return }
        
        let messageCompose = MFMessageComposeViewController()
        messageCompose.messageComposeDelegate = self
        
        // Configure the fields of the interface
        messageCompose.recipients = ["34688499905"]
        messageCompose.body = "Hello John!"
        
        if MFMessageComposeViewController.canSendAttachments(), let image = imageView.image {
            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
            let filename = getDocumentsDirectory().appendingPathComponent("copy.jpg")
            try? data.write(to: filename)
            
            messageCompose.addAttachmentData(data, typeIdentifier: "copy", filename: "copy.jpg")
        }
        
        // Present the view controller modally
        present(messageCompose, animated: true, completion: nil)
        
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        imageView.image = selectedImage
        dismiss(animated: true)
    }
}
// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {}

// MARK: - MFMailComposeViewControllerDelegate
extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
}

//MARK: - MFMessageComposeViewControllerDelegate
extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}

