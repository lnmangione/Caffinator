//
//  DetailsViewController.swift
//  Caffinator
//
//  Created by Luigi Mangione on 3/21/17.
//  Copyright © 2017 AppRoar Studios. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.showMenu),
            name: Notification.Name("ShowMenu"),
            object: nil)

        // Do any additional setup after loading the view.
    }
    
    func showMenu(){
        self.present(MenuViewController(), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
