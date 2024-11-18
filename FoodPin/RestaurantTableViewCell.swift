//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by doniyor normuxammedov on 18/11/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!{
        didSet{
//            thumbnailImageView.layer.cornerRadiu/*s = thumbnailImageView.bounds.width / 2*/
            thumbnailImageView.clipsToBounds = true
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
