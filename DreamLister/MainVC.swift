//
//  MainVC.swift
//  DreamLister
//
//  Created by Younoussa Ousmane Abdou on 11/28/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        generateTestData()
        attemptFetch()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        configCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configCell(cell: ItemCell, indexPath: NSIndexPath) {
        
        let item = controller.object(at: (indexPath as NSIndexPath) as IndexPath)
        
        cell.configCell(item: item)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    // Core Data functions
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            
            try controller.performFetch()
        } catch {
            
            let error = error as NSError
            
            print(error)
        }
        
        self.controller = controller
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .insert:
            
            if let indexPath = newIndexPath {
                
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            
            break
            
        case .delete:
            
            if let indexPath = indexPath {
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            break
            
        case .update:
            
            if let indexPath = indexPath {
                
                let selectedCell = tableView.cellForRow(at: indexPath) as? ItemCell
                
                configCell(cell: selectedCell!, indexPath: indexPath as NSIndexPath)
                
                
            }
            
            break
            
        case .move:
            
            if let indexPath = indexPath {
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            
            if let indexPath = newIndexPath {
                
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            
            break
        }
    }
    
    func generateTestData() {
        
        let item1 = Item(context: context)
        item1.title = "MacBook Pro"
        item1.price = 1800
        item1.details = "Not bad"
        
        let item2 = Item(context: context)
        item2.title = "Tesla"
        item2.price = 80000
        item2.details = "Awesome car that I have been dreamed of"
        
        let item3 = Item(context: context)
        item3.title = "NS_Yuso"
        item3.price = 99999
        item3.details = "IDK yet but the future will reveal us what it is"
        
        ad.saveContext()
    }
}

