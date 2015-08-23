//
//  NewsTableViewController.swift
//  
//
//  Created by Qin Yubo on 15/8/23.
//
//

import UIKit

class NewsTableViewController: UITableViewController {
    
//    enum NewsType: Int {
//        case News = 0
//        case Column = 1
//    }
    
    @IBOutlet var typeSegmentedControl: UISegmentedControl!
    
    var dataArr = [NewsTitleData]()
    var currentPage = 1
    var type = 0
    var selectedCellIndex = ""
    var selectedTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.respondsToSelector("automaticallyAdjustsScrollViewInsets") && self.navigationController!.navigationBar.translucent == true {
            self.automaticallyAdjustsScrollViewInsets = false
            
            var insets = self.tableView.contentInset
            insets.top = self.navigationController!.navigationBar.bounds.size.height + UIApplication.sharedApplication().statusBarFrame.size.height
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
        }
        
        weak var weakSelf: NewsTableViewController! = self
        self.tableView.addPullToRefreshWithActionHandler({
            weakSelf.refreshData()
        })
        self.tableView.addInfiniteScrollingWithActionHandler({
            weakSelf.loadMore()
        })
        
        self.refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func segmentedChanged(sender: AnyObject) {
        let senderSegmentedControl = sender as! UISegmentedControl
        type = senderSegmentedControl.selectedSegmentIndex
        self.refreshData()
    }
    
    // MARK: - private methods
    
    private func refreshData() {
        currentPage = 1
        dataArr.removeAll(keepCapacity: false)
        tableView.reloadData()
        self.getData()
    }
    
    private func loadMore() {
        currentPage = currentPage + 1
        self.getData()
    }
    
    private func getData() {
        NewsDataManager.getNewsData(type, page: currentPage, success: { arr in
            if self.currentPage == 1 {
                self.dataArr = arr
            } else if self.currentPage > 1 {
                if arr.count == 0 {
                    MsgDisplay.showErrorMessage("Last Page Reached")
                    self.currentPage = self.currentPage - 1
                } else {
                    self.dataArr = self.dataArr + arr
                }
            }
            self.tableView.reloadData()
            self.tableView.infiniteScrollingView.stopAnimating()
            self.tableView.pullToRefreshView.stopAnimating()
        }, failure: { error in
            MsgDisplay.showErrorMessage(error)
            self.tableView.infiniteScrollingView.stopAnimating()
            self.tableView.pullToRefreshView.stopAnimating()
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.dataArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newsTableCell") as! NewsTableViewCell
        
        // Configure the cell...
        
        let tmpData = dataArr[indexPath.row]
        cell.titleLabel.text = tmpData.title
        let date = NSDate(timeIntervalSince1970: (tmpData.updateTime as NSString).doubleValue)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM月dd日 HH:mm"
        cell.timeLabel.text = dateFormatter.stringFromDate(date)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tmpData = dataArr[indexPath.row]
        self.selectedCellIndex = tmpData.index
        self.selectedTitle = tmpData.title
        self.performSegueWithIdentifier("pushNewsDetail", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "pushNewsDetail" {
            var detailViewController = segue.destinationViewController as! NewsDetailViewController
            detailViewController.index = self.selectedCellIndex
            detailViewController.title = self.selectedTitle
        }
    }

}
