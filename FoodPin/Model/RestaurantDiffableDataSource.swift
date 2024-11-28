//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by doniyor normuxammedov on 19/11/24.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {

   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
