//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by doniyor normuxammedov on 20/11/24.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    
    var restaurant: Restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
        
        // Configure HeaderView
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        let heartImage = restaurant.isFavorite ? "heart.fill": "heart"
        headerView.heartButton.tintColor = restaurant.isFavorite ? .systemYellow : .white
        headerView.heartButton.setImage(UIImage(named: heartImage), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "showMap" {
           let destinationController = segue.destination as! MapViewController
           destinationController.restaurant = restaurant
       }
   }
}




//MARK: Extension  RestaurantDetailViewController: UITableViewDataSource,UITableViewDelegate

extension RestaurantDetailViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self),for: indexPath) as! RestaurantDetailTextCell
                cell.descriptionLabel.text = restaurant.description
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoColumnCell.self),for: indexPath) as! RestaurantDetailTwoColumnCell
                cell.column1TitleLabel.text = "Address"
                cell.column1TextLabel.text = restaurant.location
                cell.column2TitleLabel.text = "Phone"
                cell.column2TextLabel.text = restaurant.phone
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: RestaurantDetailMapCell.self) , for: indexPath) as! RestaurantDetailMapCell
                cell.configure(location: restaurant.location)
                cell.selectionStyle = .none
                return cell
                
            default:
                fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    
}
