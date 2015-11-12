//
//  TopTableViewController.swift
//  PeekAndPopSample
//
//  Created by Ryota Iwai on 2015/11/11.
//  Copyright © 2015年 Ryota Iwai. All rights reserved.
//

import UIKit

class TopTableViewController: UIViewController {

    // MARK: - Outlet property
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Override method
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Private method
    private func backgroundColorWithIndexPath(indexPath: NSIndexPath) -> UIColor {
        switch indexPath.row % 5 {
        case 0:
            return UIColor.redColor()
        case 1:
            return UIColor.blueColor()
        case 2:
            return UIColor.yellowColor()
        case 3:
            return UIColor.greenColor()
        case 4:
            return UIColor.purpleColor()
        default:
            return UIColor.redColor()
        }
    }

    private func fontColorWithIndexPath(indexPath: NSIndexPath) -> UIColor {
        switch indexPath.row % 5 {
        case 0:
            return UIColor.whiteColor()
        case 1:
            return UIColor.whiteColor()
        case 2:
            return UIColor.blackColor()
        case 3:
            return UIColor.whiteColor()
        case 4:
            return UIColor.whiteColor()
        default:
            return UIColor.whiteColor()
        }
    }
}

// MARK: - UITableViewDataSource
extension TopTableViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("NormalCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = String(indexPath.row)
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(20)
        cell.textLabel?.textAlignment = .Center
        
        cell.backgroundColor = self.backgroundColorWithIndexPath(indexPath)
        cell.textLabel?.textColor = self.fontColorWithIndexPath(indexPath)
        
        // For peek and pop
        if #available(iOS 9.0, *) {
            if UIApplication.sharedApplication().keyWindow?.traitCollection.forceTouchCapability == .Available {
                self.registerForPreviewingWithDelegate(self, sourceView: cell)
            }
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension TopTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        guard let popedViewController = UIStoryboard(name: "PopedViewController", bundle: nil).instantiateViewControllerWithIdentifier("PopedViewController") as? PopedViewController else {
            return
        }
        
        popedViewController.labelString = String(indexPath.row)
        popedViewController.fontColor = self.fontColorWithIndexPath(indexPath)
        popedViewController.backgroundColor = self.backgroundColorWithIndexPath(indexPath)
        
        self.navigationController?.pushViewController(popedViewController, animated: true)
    }
}

// MARK: - UIViewControllerPreviewingDelegate
@available(iOS 9.0, *)
extension TopTableViewController: UIViewControllerPreviewingDelegate {
    
    // Peek
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let cell = previewingContext.sourceView as? UITableViewCell else {
            return nil
        }
        guard let indexPath = self.tableView.indexPathForCell(cell) else {
            return nil
        }
        guard let popedViewController = UIStoryboard(name: "PopedViewController", bundle: nil).instantiateViewControllerWithIdentifier("PopedViewController") as? PopedViewController else {
            return nil
        }

        // POINT!
        self.tableView.reloadData()
        
        popedViewController.labelString = String(indexPath.row)
        popedViewController.fontColor = self.fontColorWithIndexPath(indexPath)
        popedViewController.backgroundColor = self.backgroundColorWithIndexPath(indexPath)

        return popedViewController
    }
    
    // Pop
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {

        guard let popedViewController = viewControllerToCommit as? PopedViewController else {
            return
        }
        popedViewController.changeColor()
        self.navigationController?.pushViewController(popedViewController, animated: true)
        
        return
    }
}
