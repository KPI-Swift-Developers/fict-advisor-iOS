//
//  RewiewsViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 03.10.2022.
//

import UIKit

class RewiewsViewController: UIViewController {

    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "sas"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(label)
        label.center = view.center
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
