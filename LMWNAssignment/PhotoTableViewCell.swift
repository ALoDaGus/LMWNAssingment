//
//  PhotoTableViewCell.swift
//  LMWNAssignment
//
//  Created by TPmac on 19/3/2565 BE.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var avataImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var camNameLabel: UILabel!
    
    func set(url: String, name: String, description: String, likeCount: String, liked: Bool, avataImage: String, ownerName: String, camName: String){
        nameLabel.text = name
        descriptionLabel.text = description
        likeCountLabel.text = formatNumber(likeCount)
        ownerNameLabel.text = ownerName
        camNameLabel.text = camName
        
        
        
        
        let url = URL(string: url)!
        
        if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                photoImage.image = UIImage(data: data)
            }
        
    }
    
    func formatNumber(_ number: String) -> String{
        let largeNumber: Int? = Int(number)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: largeNumber!))
        return formattedNumber!
    }
    
}
