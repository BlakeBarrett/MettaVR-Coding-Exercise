//
//  ViewController.swift
//  MettaVR Coding Exercise
//
//  Created by Blake Barrett on 6/4/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

import UIKit

class MettaVideoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let metaAPIUrl = NSURL(string: "http://www.mettavr.com/api/codingChallengeData")
    
    var items = [MettaItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadDataFromAPI()
    }
    
    // MARK: TableViewDelegate and DataSource implementation methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mettaItemCellReuseIdentifier", forIndexPath: indexPath) as! MettaItemCellView
        let item = items[indexPath.row]
        
        cell.titleLabelView.text = item.title
        cell.geographyLabelView.text = item.geography
        cell.backgroundImageView.image = nil
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            guard let url = item.previewUrl else { return }
            guard let imageData = NSData(contentsOfURL: url) else { return }
            guard let image = UIImage(data: imageData) else { return }
            
            dispatch_async(dispatch_get_main_queue()) {
                cell.backgroundImageView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        
        // show the item selected
        self.present360(item)
    }

    func present360(item:MettaItem) {
        let videoUrl = item.copies?.first?.url
        let player = HTY360PlayerWrapperViewController(url: videoUrl!)
        self.presentViewController(player, animated: true) { 
            
        }
    }
    
    
    // MARK: Network IO bits
    func loadDataFromAPI() {
        guard let url = self.metaAPIUrl else { return }
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            if let response = (response as? NSHTTPURLResponse) {
                if (response.statusCode == 401) {
                    
                    return
                }
            }
            
            guard let data = data else { return }
            
            var results = []
            do {
                let rawResults = (try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments))
                results = rawResults as! NSArray
            } catch (let error) {
                print(error)
                return
            }
            
            self.items = self.parseItemsFromJSONResult(results)
            
            self.tableView.reloadData()
            
        })
        task.resume()
    }
    
    func parseItemsFromJSONResult(items:NSArray) -> [MettaItem] {
        var parsed = [MettaItem]()
        
        items.forEach { (item: AnyObject) in
            guard let itemDict = item as? NSDictionary else { return }
            let mettaItem = MettaItem(info: itemDict)
            parsed.append(mettaItem)
        }
        
        return parsed
    }
}

