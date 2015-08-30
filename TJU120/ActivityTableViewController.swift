//
//  ActivityTableViewController.swift
//  TJU120
//
//  Created by yaozican on 15/8/29.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var tpyeSegmentedControl: UISegmentedControl!
    var collegeTitleFixedView = CollegeTitleFixedView()
    var dataArr = [ActivityTitleData]()
    var currentPage = 1
    var type = 0
    var selectedCellIndex = ""
    var selectedTitle = ""
    var collegeLabel:UILabel!
    var pickerBtn:UIButton!
    var collegePicker:UIPickerView!
    var CollegeArr = ["机械学院", "经管学部", "软件学院"]
    var collegeStr:String!
    var collegeAddress = "jxgcxy"
    
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
        
        //add collegeLabel
        collegeLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 100, height: 20))
        collegeLabel.center = CGPointMake(self.view.frame.size.width/2, collegeTitleFixedView.frame.size.height/2)
        collegeLabel.text = "机械学院"
        collegeLabel.textAlignment = NSTextAlignment.Center
        collegeLabel.font = UIFont.boldSystemFontOfSize(18)
        collegeTitleFixedView.addSubview(collegeLabel)
        
        //add pickerBtn
        pickerBtn = UIButton(frame:CGRectMake(0, 0, 60, 20))
        pickerBtn.center = CGPointMake(self.view.frame.size.width-40, collegeTitleFixedView.frame.size.height/2)
        pickerBtn.setTitle("选择", forState: UIControlState.Normal)
        pickerBtn.setTitle("选择", forState: UIControlState.Highlighted)
        pickerBtn.addTarget(self, action: "buttonIsPressed:", forControlEvents: UIControlEvents.TouchDown)
        pickerBtn.addTarget(self, action: "showPicker:", forControlEvents: UIControlEvents.TouchUpInside)
        collegeTitleFixedView.addSubview(pickerBtn)
        
        //声明
        collegeTitleFixedView.backgroundColor = UIColor.cyanColor()
        collegeTitleFixedView.frame = CGRectMake(0, -40, self.view.frame.size.width, 40)
        
        var index = tpyeSegmentedControl.selectedSegmentIndex
                //刷新获取数据
        self.refreshData()
    }
    
    
    func buttonIsPressed(sender:UIButton){
        println("Button is Pressed.")
    }
    
    func buttonIsTaped(sender:UIButton){
        println("Button is Taped")
    }
    
    func showPicker(sender:UIButton){
        var alert = UIAlertController(title:"",message:"\n\n\n\n\n\n\n\n\n", preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        //Create a frame (placeholder/wrapper) for the picker and then create the picker
        var pickerFrame: CGRect = CGRectMake(17, 52, 270, 100)
        var picker: UIPickerView = UIPickerView(frame:pickerFrame)
        
        //set the pickers datasourse and delegate
        picker.delegate = self
        picker.dataSource = self
        
        //add the picker to the alertcontroller
        alert.view.addSubview(picker)
        
        //create the toolbar view which will hold our 2 buttons
        var toolFrame = CGRectMake(17, 5, 270, 45)
        var toolView: UIView = UIView(frame: toolFrame)
        
        //add buttons to the view
        var buttonCancelFrame: CGRect = CGRectMake(0, 7, 100, 30)
        
        //create the cancel button
        var buttonCancel: UIButton = UIButton(frame:buttonCancelFrame)
        buttonCancel.setTitle("Cancel", forState: UIControlState.Normal);
        buttonCancel.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonCancel); //add it to the toolView
    
        //Add the target - target, function to call, the event witch will trigger the function call
        buttonCancel.addTarget(self, action: "cancelSelection:", forControlEvents: UIControlEvents.TouchDown)
        
        //add buttons to the view
        var buttonOkFrame: CGRect = CGRectMake(170, 7, 100, 30)
        
        //Create the Select button & set the title
        var buttonOk: UIButton = UIButton(frame: buttonOkFrame)
        buttonOk.setTitle("Select", forState: UIControlState.Normal)
        buttonOk.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        toolView.addSubview(buttonOk) //add to the subview
        
        buttonOk.addTarget(self, action: "saveCollege:", forControlEvents: UIControlEvents.TouchDown)
        
        //add the toolbar to the alert controller
        alert.view.addSubview(toolView)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveCollege(sender:UIButton){
        println("选择")
        self.dismissViewControllerAnimated(true, completion: nil)
        collegeLabel.text = collegeStr
        switch collegeStr{
            case "机械学院": collegeAddress = "jxgcxy"
            case "经管学部": collegeAddress = "glyjjxb"
            default: collegeAddress = "rjgcxy"
        }
        self.refreshData()
        
    
        
    }
    
    func cancelSelection(sender:UIButton){
        println("Cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return CollegeArr.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return CollegeArr[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collegeStr = CollegeArr[row]
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
            collegeTitleFixedView.removeFromSuperview()
            self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, tableView.frame.size.height)
        }else{
            self.tableView.frame = CGRectMake(0, 40, self.tableView.frame.size.width, tableView.frame.size.height)
            //添加CollegeTitleFixedView
            self.view.addSubview(collegeTitleFixedView.self)
        }
        
        self.refreshData()
    }
    
    @IBAction func segmentedValueChanged(sender: AnyObject) {
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
        ActivityDataManager.getActivityData(collegeAddress, type: type, page: currentPage, success: { arr in
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
        cell.startTimeLabel.text = tmpData.start_time
        cell.placeLabel.text = tmpData.at_place
        cell.sourceLabel.text = tmpData.source
        let date = NSDate(timeIntervalSince1970: (tmpData.create_time as NSString).doubleValue)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM月dd日 HH:mm"
        //cell.timeLabel.text = dateFormatter.stringFromDate(date)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tmpData = dataArr[indexPath.row]
        self.selectedCellIndex = tmpData.index
        
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
