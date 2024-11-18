//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by doniyor normuxammedov on 12/11/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    lazy var dataSource = configureDataSource()
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]

    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = dataSource

            var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
            snapshot.appendSections([.all])
            snapshot.appendItems(restaurantNames, toSection: .all)

            dataSource.apply(snapshot, animatingDifferences: false)
   
    }
    
  
    enum Section {
    case all
    }
    
    // MARK: TableViewDataSource
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "favoritecell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

                cell.nameLabel?.text = restaurantName
                cell.thumbnailImageView?.image = UIImage(named: self.restaurantImages[indexPath.row])
                cell.accessoryType = self.restaurantIsFavorites[indexPath.row] ? .checkmark : .none

                return cell
            }
        )

        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

            // Configure the cell...
            cell.textLabel?.text = restaurantNames[indexPath.row]
            cell.imageView?.image = UIImage(named: self.restaurantImages[indexPath.row])

            return cell

    }
    
    //MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you wnat to do ", preferredStyle: .actionSheet)
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add "Reserve a table" action
        
        let reserveActionHandler = { (action: UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "Not available yet ", message: "Sorry,this feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertMessage, animated: true,completion: nil)
        }
        
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reserveAction)
        
        
        //Mark as favorite action
        
        let favoriteAction = UIAlertAction(title: "Mark as favorite", style: .default, handler: { (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            self.restaurantIsFavorites[indexPath.row] = true
        })
        optionMenu.addAction(favoriteAction)
        
        present(optionMenu, animated: true,completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    
    
}

