//
//  PickerDistanceViewController.swift
//  FindThePetrolsOnMap
//
//  Created by Dushko Cizaloski on 4/8/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class PickerDistanceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showListTdistances(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ShowList", sender: self)
    }
    
    
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var pizzaLabel: UILabel!
    let pickerData = [
        ["10\"","14\"","18\"","24\", 12\", 13\", 17\""],
        ["Cheese","Pepperoni","Sausage","Veggie","BBQ Chicken","da","ne"]
    ]
    
    let sizeComponent = 0
    let toppingComponent = 1
    
    
    
    //MARK: - Picker View Data Sources and Delegates
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        updateLabel()
    }
    
    //MARK: - Instance Methods
    func updateLabel(){
        let size = pickerData[sizeComponent][myPicker.selectedRow(inComponent: sizeComponent)]
        let topping = pickerData[toppingComponent][myPicker.selectedRow(inComponent: toppingComponent)]
        pizzaLabel.text = "Pizza: " + size + " " + topping
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate = self
        myPicker.dataSource = self
        myPicker.selectRow(2, inComponent:sizeComponent, animated: false)
        updateLabel()
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
