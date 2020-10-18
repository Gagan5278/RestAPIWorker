//
//  UIViewController+Extension.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertMessage(with title: String, message: String, completionHandler: @escaping(UIAlertAction) -> Void) {
        //1. Alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //2. Action
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: completionHandler)
        //3. Add Action to Alert
        alertController.addAction(alertAction)
        //4.
        self.present(alertController, animated: true, completion: nil)
    }
}
