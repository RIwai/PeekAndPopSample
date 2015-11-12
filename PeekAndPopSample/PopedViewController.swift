//
//  PopedViewController.swift
//  PeekAndPopSample
//
//  Created by Ryota Iwai on 2015/11/12.
//  Copyright © 2015年 Ryota Iwai. All rights reserved.
//

import UIKit

class PopedViewController: UIViewController {

    // MARK: - Outlet property
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var label: UILabel!

    // MARK: - Internal property
    var backgroundColor = UIColor.clearColor()
    var fontColor = UIColor.clearColor()
    var labelString = ""
    
    // MARK: - Override method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.containerView.backgroundColor = self.backgroundColor

        self.label.textColor = self.fontColor
        self.label.text = self.labelString
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.containerView.layer.cornerRadius = self.containerView.frame.width / 2
        self.label.font = UIFont.boldSystemFontOfSize(self.containerView.frame.width / 5)
    }
    
    // MARK: - Internal method
    func changeColor() {
        self.view.backgroundColor = self.backgroundColor
        self.containerView.backgroundColor = UIColor.whiteColor()
        self.label.textColor = UIColor.blackColor()
    }
}

// MARK: - For peek quick actions
extension PopedViewController {
    @available(iOS 9.0, *)
    override func previewActionItems() -> [UIPreviewActionItem] {
        return [
            UIPreviewAction(title: "1", style: .Default, handler: { (action, viewController) -> Void in
                self.label.text = "1"}),
            UIPreviewAction(title: "2", style: .Default, handler: { (action, viewController) -> Void in
                self.label.text = "2"
            }),
            UIPreviewAction(title: "3", style: .Default, handler: { (action, viewController) -> Void in
                self.label.text = "3"
            }),
            UIPreviewAction(title: "4", style: .Default, handler: { (action, viewController) -> Void in
                self.label.text = "4"
            })
        ]
    }
}
