import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	//MARK: Properties
	@IBOutlet weak var mealNameTextField: UITextField!
	@IBOutlet weak var mealPhoto: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	@IBOutlet weak var cancelButton: UIBarButtonItem!
	
	var meal: Meal?
    
	override func viewDidLoad() {
		super.viewDidLoad()
		mealNameTextField.delegate = self
		if let meal = meal {
			navigationItem.title = meal.name
			mealNameTextField.text = meal.name
			mealPhoto.image = meal.photo
			ratingControl.rating = meal.rating
		}
		updateSaveButtonState()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: Navigation
	@IBAction func cancel(_ sender: UIBarButtonItem) {
		let isPresentingInAddMealMode = presentingViewController is UINavigationController
		if(isPresentingInAddMealMode){
			dismiss(animated: true, completion: nil)
		} else if let ownNavigationController = navigationController {
			ownNavigationController.popViewController(animated: true)
		} else {
			fatalError("The MealViewController is not inside NavigationController!")
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		guard let button = sender as? UIBarButtonItem, button === saveButton else {
			os_log("The save button wasn't pressed. Cancelling", log: OSLog.default, type: .debug)
			return
		}
		let name = mealNameTextField.text ?? ""
		let photo = mealPhoto.image
		let rating = ratingControl.rating
		meal = Meal(name: name, photo: photo, rating: rating)
	}
	
	@IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
		mealNameTextField.resignFirstResponder()
		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .photoLibrary
		imagePicker.delegate = self
		present(imagePicker, animated: true, completion: nil)
	}
	
	//MARK: UITextFieldDelegate
	func textFieldDidBeginEditing(_ textField: UITextField) {
		saveButton.isEnabled = false
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		updateSaveButtonState()
		navigationItem.title = textField.text
	}
	
	//MARK: UIImagePickerControllerDelegate
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
			fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
		}
		mealPhoto.image = selectedImage
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: - Private Methods
	private func updateSaveButtonState() {
		saveButton.isEnabled = !(mealNameTextField.text ?? "").isEmpty
	}
}
