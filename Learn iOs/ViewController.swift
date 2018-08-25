//
//  ViewController.swift
//  Learn iOs
//
//  Created by  Andrew on 13/08/2018.
//  Copyright © 2018  Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	//MARK: Properties
	@IBOutlet weak var mealNameLabel: UILabel!
	@IBOutlet weak var mealNameTextField: UITextField!
	@IBOutlet weak var mealPhoto: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Handle the text field’s user input through delegate callbacks.
		mealNameTextField.delegate = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//MARK: Actions
	@IBAction func setDefaultLabelText(_ sender: UIButton) {
		mealNameLabel.text = "Default name"
	}
	
	@IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
		mealNameTextField.resignFirstResponder()
		// UIImagePickerController is a view controller that lets a user pick media from their photo library.
		let imagePicker = UIImagePickerController()
		// Only allow photos to be picked, not taken.
		imagePicker.sourceType = .photoLibrary
		imagePicker.delegate = self
		present(imagePicker, animated: true, completion: nil)
	}
	
	//MARK: UITextFieldDelegate
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		mealNameLabel.text = mealNameTextField.text
	}
	
	//MARK: UIImagePickerControllerDelegate
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		// Dismiss the picker if the user canceled.
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		// The info dictionary may contain multiple representations of the image. You want to use the original.
		guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
			fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
		}
		mealPhoto.image = selectedImage
		dismiss(animated: true, completion: nil)
	}
}
