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
    @IBOutlet weak var avataImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var camNameLabel: UILabel!
        
    
    func set(url: String, name: String, description: String, likeCount: Int, avataImage: String, ownerName: String, camName: String){
        nameLabel.text = name
        descriptionLabel.text = description
        likeCountLabel.text = formatNumber(likeCount)
        ownerNameLabel.text = ownerName
        camNameLabel.text = camName
        camNameLabel.isHidden = camName == "" ? true: false
        photoImage.downloaded(from: url, contentMode: .scaleAspectFill)
        self.avataImage.downloaded(from: avataImage, contentMode: .scaleAspectFill)
    }
    
    func downloadBigImg(_ url: String) -> UIImage? {
        let imgURL = URL(string: url)!
        guard let data = try? Data(contentsOf: imgURL) else { return nil }
            
        let image = UIImage(data:  data)
        return image
    }
    
    func formatNumber(_ number: Int) -> String{
        let largeNumber: Int? = number
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: largeNumber!))
        return formattedNumber!
    }
    
}

