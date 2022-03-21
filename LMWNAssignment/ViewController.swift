//
//  ViewController.swift
//  LMWNAssignment
//
//  Created by TPmac on 19/3/2565 BE.
//

import UIKit

class ViewController: UIViewController{
    
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!{
        didSet{
            loadingView.layer.cornerRadius = 6
        }
    }
    
    var currentPage = 1 {
        didSet{
            loadData()
        }
    }
    
    var listOfPhotos = [PhotoDetail](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.scrollToTop()
                self.hideSpinner()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageButton.addTarget(self, action: #selector(onClickNextPage), for: .touchUpInside)
        previousPageButton.addTarget(self, action: #selector(onClickPreviousPage), for: .touchUpInside)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        loadData()
    }
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topRow, at: .top, animated: false)
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    @objc func onClickNextPage(){
        currentPage += 1
    }
    
    @objc func onClickPreviousPage(){
        if currentPage <= 1{ return }
        currentPage -= 1
    }
    
    @objc func loadData(){
        showSpinner()
        currentPageLabel.text = "\(currentPage)"
        let photoRequest = PhotosRequest(page: currentPage)
        photoRequest.getPhotos{ [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self?.listOfPhotos = photos
            }
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPhotos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell

        let photo = listOfPhotos[indexPath.row]

        cell.set(url: photo.image_url[0], name: photo.name, description: photo.description, likeCount: photo.votes_count, avataImage: photo.user.avatars.tiny.https, ownerName: photo.user.fullname, camName: photo.camera)

        return cell
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
