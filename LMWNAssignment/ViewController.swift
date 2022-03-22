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
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageButton.addTarget(self, action: #selector(onClickNextPage), for: .touchUpInside)
        previousPageButton.addTarget(self, action: #selector(onClickPreviousPage), for: .touchUpInside)
        
        loadingView.layer.cornerRadius = 6
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        loadData()
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
                self.refreshControl.endRefreshing()
                self.hideSpinner()
            }
        }
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
