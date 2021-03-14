//
//  UIViewControllerExtensions.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import Foundation
import UIKit



extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
