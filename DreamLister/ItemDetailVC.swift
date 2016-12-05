//
//  ItemDetailVC.swift
//  DreamLister
//
//  Created by Younoussa Ousmane Abdou on 11/30/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlets
    
    @IBOutlet weak var thumbIMG: UIImageView!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    
    // Actions
    
    @IBAction func deleteBTNPressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBTNPressed(_ sender: UIButton) {
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbIMG.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
        } else {
            
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            
            item.title = title
        }
        
        if let price = priceField.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let detail = detailField.text {
            
            item.details = detail
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbIMG.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // Variables and Constants
    
    var stores = [Store]()
    
    var itemToEdit: Item?
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        // Picker Setup
        
        storePicker .delegate = self
        storePicker.dataSource = self
        
//        generateTestData()
        
        getStores()
        
        if itemToEdit != nil {
            
            loadItemData()
        }
        
        // Image Setup
        
        imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
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
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailField.text = item.details
            thumbIMG.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                
                repeat {
                    
                    let s = stores[index]
                    
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: true)
                        
                        index += 1
                    }
                } while index < stores.count
            }
        }
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
