//
//  ItemDetailVC.swift
//  DreamLister
//
//  Created by Younoussa Ousmane Abdou on 11/30/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        storePicker .delegate = self
        storePicker.dataSource = self
        
//        generateTestData()
        
        getStores()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
         let store = stores[row]
        
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Update it later
        
        
    }
    
    // Core data functions
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
            let error = error as NSError
            
            print(error)
        }
        
    }
    
    func generateTestData() {
        
        let store1 = Store(context: context)
        store1.name = "Best Buy"
        
        let store2 = Store(context: context)
        store2.name = "Amazon"
        
        let store3 = Store(context: context)
        store3.name = "K Mart"
        
        let store4 = Store(context: context)
        store4.name = "Fry Electronics"
        
        let store5 = Store(context: context)
        store5.name = "Target"
        
        ad.saveContext()
    }
}
