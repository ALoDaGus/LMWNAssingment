//
//  extensionUITableView.swift
//  LMWNAssignment
//
//  Created by TPmac on 22/3/2565 BE.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPhotos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell

        let photo = listOfPhotos[indexPath.row]

        cell.set(url: photo.image_url[0], name: photo.name, description: photo.description, likeCount: photo.votes_count, avataImage: photo.user.avatars.large.https, ownerName: photo.user.fullname, camName: photo.camera)

        return cell
    }
}
