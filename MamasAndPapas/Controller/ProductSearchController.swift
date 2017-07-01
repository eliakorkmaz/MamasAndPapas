//
//  ProductSearchController.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/27/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Vendors
import Signals
import Kingfisher

class ProductSearchController: UITableViewController, UITableViewDataSourcePrefetching {
    @IBOutlet weak var refresher: UIRefreshControl!
    
    @available(iOS 2.0, *)
    func tableView(_: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.flatMap { paginator.hits[$0.row]["image"].asCDNURL }
        ImagePrefetcher(urls: urls).start()
    }
    
    var paginator: HitPaginattor = HitPaginattor()
    
    override func viewDidLoad() {
        tableView.prefetchDataSource = self
        paginator.nextPageSignal.subscribe(on: self) { page, hitsPerPage in
            
            self.searchProvider.request(.search(searchString: "", page: page, hitsPerPage: hitsPerPage)) { [weak self] result in
                guard let `self` = self else {
                    return
                }
                
                guard case let .success(response) = result else {
                    return
                }
                
                self.paginator.append(json: response.mapSwiftyJSON())
            }
        }
        
        paginator.hitsUpdatedSignal.subscribe(on: self) { _ in
            self.tableView.reloadData()
        }
        
        paginator.next()
        
        refresher.backgroundColor = UIColor.clear
        refresher.tintColor = UIColor.black
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    
    func refresh() {
        paginator.refreshSignal.subscribeOnce(on: self) { [weak self] _, _ in
            guard let `self` = self else {
                return
            }
            
            self.searchProvider.request(.search(searchString: "", page: 0, hitsPerPage: 10)) { [weak self] result in
                guard let `self` = self else {
                    return
                }
                
                self.refresher.endRefreshing()
                
                guard case let .success(response) = result else {
                    return
                }
                
                self.paginator.prepend(json: response.mapSwiftyJSON())
            }
        }
        
        paginator.refresh()
    }
    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 120
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if paginator.hits.count > 0 {
            
            self.tableView.separatorStyle = .singleLine
            return 1
            
        } else {
            
            let messageLabel = UILabel(frame: CGRect.zero)
            messageLabel.text = "No data is currently available. Please pull down to refresh."
            messageLabel.textColor = UIColor.black
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 24)
            messageLabel.sizeToFit()
            let container = UIView()
            container.addSubview(messageLabel)
            
            let edgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
            messageLabel.fillSuperView(edgeInsets)
            
            tableView.backgroundView = container
            tableView.separatorStyle = .none
            
        }
        return 1
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return paginator.hits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchProductTableCell = tableView.dequeueReusableCell(withIdentifier: SearchProductTableCell.objectName, for: indexPath) as! SearchProductTableCell
        cell.data = paginator.hits[indexPath.row]
        cell.imgProduct.layer.cornerRadius = 5
        return cell
    }
    
    override func tableView(_: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == paginator.hits.count - 1 { // you might decide to load sooner than -1 I guess...
            paginator.next()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let detail = segue.destination as? ProductDetailController {
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            
            let data = paginator.hits[indexPath.row]
            detail.slug = data["slug"].string
        }
    }
}
