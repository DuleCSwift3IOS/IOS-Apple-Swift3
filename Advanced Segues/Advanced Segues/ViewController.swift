//
//  ViewController.swift
//  Advanced Segues
//
//  Created by Dushko Cizaloski on 2/12/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
let globalVariable = "Dushko"
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var activeRow = 0
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ShowCell")
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }

    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        
        performSegue(withIdentifier: "GoToSecoundViewController", sender: nil)
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSecoundViewController"
        {
            let secoundViewController = segue.destination as! SecoundViewController
            
            secoundViewController.activeRow = activeRow
        }
    }

}

