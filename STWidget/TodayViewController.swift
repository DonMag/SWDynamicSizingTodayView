//
//  TodayViewController.swift
//  STWidget
//
//  Created by Don Mag on 11/25/16.
//  Copyright © 2016 Don Mag. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
        
	@IBOutlet weak var theTableView: UITableView!
	
	@IBOutlet weak var topButtonsView: UIView!
	@IBOutlet weak var bottomButtonsView: UIView!
	
	@IBOutlet weak var heightControlConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var bottomButtonsViewTopConstraint: NSLayoutConstraint!
	
	var numSections: Int = 1
	var numRows: Int = 4
	
	let myRowHeightConstant: CGFloat = 55.0
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
		
		theTableView.delegate = self
		theTableView.dataSource = self

		theTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
		
		theTableView.layoutMargins = UIEdgeInsetsZero
		theTableView.separatorInset = UIEdgeInsetsZero
		
		theTableView.separatorEffect = nil
		
		// need to "zero-out" the table header and footer
		let v: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.01))
		v.backgroundColor = UIColor.clearColor()
		theTableView.tableHeaderView = v
		theTableView.tableFooterView = v
		
		theTableView.backgroundColor = UIColor.redColor()
		
		self.updateTableSize()
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.NewData)
    }
 
	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
		return UIEdgeInsetsZero
	}
	
	// MARK: - Add/Remove rows...
	@IBAction func addRowTap(sender: AnyObject) {
		numRows = numRows + 1
		theTableView.reloadData()
		self.updateTableSize()
	}
	
	@IBAction func removeRowTap(sender: AnyObject) {
		numRows = max(numRows - 1, 0)
		theTableView.reloadData()
		self.updateTableSize()
	}

	// MARK: - widget sizing
	
	func updateTableSize() -> Void {
		
		// total height =
		//		top of tableView +
		//		number of rows * row height +
		//		height of bottom buttons container view
		//
		// Note: if no events, add one rowHeight to leave space for the "No Events" label
		
		let vTop: CGFloat = theTableView.frame.origin.y
		let nRows: Int = max(numRows, 1)
		let vRows: CGFloat = CGFloat(nRows) * myRowHeightConstant
		let vBtns: CGFloat = bottomButtonsView.frame.size.height
		
		var ttlHeight: CGFloat = vTop + vRows + vBtns

		heightControlConstraint.constant = ttlHeight
		
		ttlHeight = vTop + vRows
		
//		bottomButtonsViewTopConstraint.constant = ttlHeight
		
		print("ttlHeight: \(ttlHeight)")
	}
	

	// MARK: - TableView Data Source
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return numSections
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return numRows
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let identifier = "tableViewCellIdentifier"
		let cell = tableView.dequeueReusableCellWithIdentifier( identifier, forIndexPath: indexPath) as! TodayTableViewCell
		
		cell.layoutMargins = UIEdgeInsetsZero
		
		cell.theLabel.text = "Section: \(indexPath.section)  Row: \(indexPath.row)"
		
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		
		return myRowHeightConstant
		
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	}
	
	
 
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.0
	}
	
	
	func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.0
	}
	
	
}
