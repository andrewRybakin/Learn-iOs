import UIKit
import os.log

class MealTableViewController: UITableViewController {
	//MARK: Properties
	var meals = [Meal]()
	
	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = editButtonItem
		
		loadSampleMeals()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return meals.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "MealTableViewCell"
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
			fatalError("The dequeued cell is not an instance of MealTableViewCell.")
		}
		
		let meal = meals[indexPath.row]
		
		cell.nameLabel.text = meal.name
		cell.photoImageView.image = meal.photo
		cell.ratingController.rating = meal.rating
		
		return cell
	}
	
	// MARK: TableView Editing
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			meals.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		switch segue.identifier ?? "" {
		case "AddItem":
			os_log("Adding a new meal", log: OSLog.default, type: .debug)
		case "ShowDetail":
			guard let mealDetailViewController = segue.destination as? MealViewController else{
				fatalError("Unexpected destination: \(segue.destination)")
			}
			guard let selectedMealCell = sender as? MealTableViewCell else {
				fatalError("Unexpected sender: \(sender.debugDescription)")
			}
			guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
				fatalError("Selected meal not found!")
			}
			let selectedMeal = meals[indexPath.row]
			mealDetailViewController.meal = selectedMeal
		default:
			fatalError("Unexpected segue identifier")
		}
	}
	
	// MARK: - Actions
	@IBAction func unwindToMealList(sender: UIStoryboardSegue) {
		if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
			if let selectedIndexPath = tableView.indexPathForSelectedRow {
				meals[selectedIndexPath.row] = meal
				tableView.reloadRows(at: [selectedIndexPath], with: .none)
			} else {
				let indexPath = IndexPath(row: meals.count, section: 0)
				meals.append(meal)
				tableView.insertRows(at: [indexPath], with: .automatic)
			}
		}
	}
	
	// MARK: - Private Methods
	private func loadSampleMeals() {
		let photo1 = UIImage(named: "meal1")
		let photo2 = UIImage(named: "meal2")
		let photo3 = UIImage(named: "meal3")
		
		guard let meal1 = Meal(name: "First Meal", photo: photo1, rating: 4) else {
			fatalError("Unable to instantiate first sample meal class...")
		}
		guard let meal2 = Meal(name: "Second Meal", photo: photo2, rating: 3) else {
			fatalError("Unable to instantiate second sample meal class...")
		}
		guard let meal3 = Meal(name: "Third Meal", photo: photo3, rating: 2) else {
			fatalError("Unable to instantiate third sample meal class...")
		}
		
		meals += [meal1, meal2, meal3]
	}
}
