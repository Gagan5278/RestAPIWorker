//
//  ViewController.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    let restNetworkingObject = RestNetworking()
    var cancellable: AnyCancellable?
    //MARK:- View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !NetworkCheckMonitor.shared.netOn {
            self.showAlertMessage(with: "Error", message: "Please check for internet connectivity", completionHandler: self.alertAction(action:))
        }
    }
    
    //MARK:- Handle Activity Indicator
    fileprivate func shouldStart(running: Bool) {
        if running {
            actIndicator.startAnimating()
        }
        else {
            actIndicator.stopAnimating()
        }
    }

    //MARK:- Alert action
    fileprivate func alertAction(action: UIAlertAction)
    {
        
    }
  //MARK:- Get
    @IBAction func getRequest(_ sender: Any) {
        shouldStart(running: true)
        self.cancellable = restNetworkingObject.callService(at: RestEndPoint.getUserList, model: Employee.self).sink(receiveCompletion: {print($0)}, receiveValue: {[self] (allEmp) in
            print(allEmp as Any)
            self.shouldStart(running: false)
        })
    }
    
    //MARK:- POST
    @IBAction func postRequest(_ sender: Any) {
        shouldStart(running: true)
        self.cancellable = restNetworkingObject.callService(at: RestEndPoint.addNewUser(name: "Test", job: "Test"), model: PostModel.self).sink(receiveCompletion: {print($0)}, receiveValue: { [self](allEmp) in
            print(allEmp as Any)
            self.shouldStart(running: false)
        })
        
    }
    
    //MARK:- PUT
    @IBAction func putRequest(_ sender: Any) {
        shouldStart(running: true)
        self.cancellable = restNetworkingObject.callService(at: RestEndPoint.updateUser(name: "new", job: "job"), model: PutModel.self).sink(receiveCompletion: {print($0)}, receiveValue: { [self](allEmp) in
            print(allEmp as Any)
            self.shouldStart(running: false)
        })
    }
    
    //MARK:- Delete
    @IBAction func deleteRequest(_ sender: Any) {
        shouldStart(running: true)
        self.cancellable = restNetworkingObject.callService(at: RestEndPoint.deleteUser, model: Bool.self).sink(receiveCompletion: {print($0)}, receiveValue: { [self](allEmp) in
            print(allEmp as Any)
            self.shouldStart(running: false)
        })

    }
    
}

