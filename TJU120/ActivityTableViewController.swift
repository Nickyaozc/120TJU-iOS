//
//  ActivityTableViewController.swift
//  TJU120
//
//  Created by yaozican on 15/8/29.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

import UIKit
var collegeTitleFixedView = CollegeTitleFixedView()
class ActivityTableViewController: UITableViewController{
    

    @IBOutlet weak var tpyeSegmentedControl: UISegmentedControl!
    
    var dataArr = [ActivityTitleData]()
    var currentPage = 1
    var type = 0
    var selectedCellIndex = ""
    var selectedTitle = ""
    var collegeLabel:UILabel!
    var pickerBtn:UIButton!
    var collegePicker:UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBar颜色
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
        //？？？
        if self.respondsToSelector("automaticallyAdjustsScrollViewInsets") && self.navigationController!.navigationBar.translucent == true {
            self.automaticallyAdjustsScrollViewInsets = false
            
            var insets = self.tableView.contentInset
            insets.top = self.navigationController!.navigationBar.bounds.size.height + UIApplication.sharedApplication().statusBarFrame.size.height
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
        }
        
        //???
        weak var weakSelf: ActivityTableViewController! = self
        self.tableView.addPullToRefreshWithActionHandler({
            weakSelf.refreshData()
        })
        self.tableView.addInfiniteScrollingWithActionHandler({
            weakSelf.loadMore()
        })
        
        //刷新获取数据
        self.refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedChanged(sender: AnyObject) {
        
        let senderSegmentedControl = sender as! UISegmentedControl
        type = senderSegmentedControl.selectedSegmentIndex
        
        //给CollegeTitleFixedView留出位置
        if type == 0{
            self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, tableView.frame.size.height)
        }else{
            self.tableView.frame = CGRectMake(0, 40, self.tableView.frame.size.width, tableView.frame.size.height)
            //添加CollegeTitleFixedView
            //Declare FixedView
            collegeTitleFixedView.backgroundColor = UIColor.cyanColor()
            collegeTitleFixedView.frame = CGRectMake(0, -40, self.view.frame.size.width, 40)
            self.view.addSubview(collegeTitleFixedView.self)
            
            //添加学院名称标签
//            collegeLabel.frame = CGRectMake(0, 0, 50, 30)
//            collegeLabel.text = "机械学院"
//            collegeLabel.textAlignment = NSTextAlignment.Center
//            collegeLabel.font = UIFont.systemFontOfSize(18)
//            collegeLabel.backgroundColor = UIColor.whiteColor()
//            collegeTitleFixedView.addSubview(collegeLabel)
//            pickerBtn.frame = CGRectMake(0, 0, 40, 20)
//            pickerBtn.setTitle("选择", forState: UIControlState.Normal)
//            pickerBtn.setTitle("选择", forState: UIControlState.Highlighted)
//            collegeTitleFixedView.addSubview(pickerBtn)
            
        }
        self.refreshData()
    }
    
    
    //使CollegeTitleFixedView固定
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if type == 1{
            var fixedFrame = CGRectMake(0, -40, self.view.frame.size.width, 40)
            fixedFrame.origin.y = 24 + scrollView.contentOffset.y
            collegeTitleFixedView.frame = fixedFrame
            collegeTitleFixedView.backgroundColor = UIColor.cyanColor()
        }else{
            collegeTitleFixedView.backgroundColor = UIColor.clearColor()
            collegeTitleFixedView.frame = CGRectMake(0,-40,self.view.frame.size.width, 40)
        }
    }
    
    // MARK: - Table view data source
    
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
        ActivityDataManager.getActivityData(type, page: currentPage, success: { arr in
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

//    override func tableView(tableView: UITableView, viewForHeaderInSection
//        section: Int) -> UIView? {
//        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! ActivityHeaderCell
//        headerCell.backgroundColor = UIColor.cyanColor()
//        headerCell.headerLabel.text = "机械学院"
//        if type == 0{
//            return nil
//        }else{
//            return headerCell
//        }
//    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.dataArr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityTableCell") as! ActivityTableViewCell

        // Configure the cell...
        
        let tmpData = dataArr[indexPath.row]
        cell.titleLabel.text = tmpData.title
        let date = NSDate(timeIntervalSince1970: (tmpData.create_time as NSString).doubleValue)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM月dd日 HH:mm"
        //cell.timeLabel.text = dateFormatter.stringFromDate(date)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tmpData = dataArr[indexPath.row]
        self.selectedCellIndex = tmpData.index
        self.selectedTitle = tmpData.title
        self.performSegueWithIdentifier("pushActivityDetail", sender: self)
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
        if segue.identifier == "pushActivityDetail" {
            var detailViewController = segue.destinationViewController as! ActivityDetailViewController
            detailViewController.index = self.selectedCellIndex
            detailViewController.title = self.selectedTitle
            detailViewController.hidesBottomBarWhenPushed = true
        }
    }
    

}
