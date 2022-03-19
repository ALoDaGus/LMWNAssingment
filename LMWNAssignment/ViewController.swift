//
//  ViewController.swift
//  LMWNAssignment
//
//  Created by TPmac on 19/3/2565 BE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let photoList = [
        PhotoInfo(url: "https://drscdn.500px.org/photo/1045672692/q%3D50_h%3D450/v2?sig=05716028d25d079b4f43f20c2689abe32622b8734d721892f1009de2e7af35fb", name: "Bogdana", description: "Posing guides, Tutorials, Backstage videos, NSFW content and tons of unpublished stuff: www.patreon.com/seanarcherphoto", likeCount: "1486", liked: true, avataurl: "", ownerName: "Owner1", camName: "nickon111"),
        PhotoInfo(url: "https://drscdn.500px.org/photo/1045665148/q%3D50_h%3D450/v2?sig=57dc3adf39e9ae4e07022cc78363737e76225ae4459d7648636306a7676cfbb2", name: "Painted Sky 2", description: "Sunset at Batu Layar, Sawarna Beach, Banten Province, Indonesia.", likeCount: "813", liked: true, avataurl: "", ownerName: "Owner2", camName: "nickon222"),
        PhotoInfo(url: "https://drscdn.500px.org/photo/1045665148/q%3D50_h%3D450/v2?sig=57dc3adf39e9ae4e07022cc78363737e76225ae4459d7648636306a7676cfbb2", name: "aaaaaaaaaaaaaaaaaasasasdasdasdasdasdasdasdasdadasdasd", description: "Sunset at Batu Layar, Sawarna Beach, Banten Province, Indonesia.Sunset at Batu Layar, Sawarna Beach, Banten Province, Indonesia.Sunset at Batu Layar, Sawarna Beach, Banten Province, Indonesia.", likeCount: "813", liked: true, avataurl: "", ownerName: "Owner3", camName: "nickon333"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        
        let photo = photoList[indexPath.row]
        
        cell.set(url: photo.url, name: photo.name, description: photo.description, likeCount: photo.likeCount, liked: photo.liked, avataImage: photo.avataurl, ownerName: photo.ownerName, camName: photo.camName)
        
        return cell
    }
    
}
