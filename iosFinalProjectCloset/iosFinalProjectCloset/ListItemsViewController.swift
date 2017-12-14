//
//  ListItemsViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData

class ListItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listedItems: UITableView!
    
    var items: [Item] = []
    var images:[UIImage] = []
    var clothing: Int?
    var weather: Int?
    var formal: Int?
    var photoItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "category == %@ AND weatherTag == %@ AND formalTag == %@", "\(clothing ?? 0)", "\(weather ?? 0)", "\(formal ?? 0)")
        
        do {
            items = try managedContext.fetch(fetchRequest)
        } catch _ {
            print("Could not fetch.")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photoItem = items[indexPath.row]
        
        performSegue(withIdentifier: "selectRow", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        images.append((items[indexPath.row].photo)!)
        cell.imageView?.image = images[indexPath.row]
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "selectRow":
            if let destination = segue.destination as? EditItemViewController{
                if let photoItem = photoItem {
                    destination.photoItem = photoItem
                    destination.photo = photoItem.photo
                }
            }
        default:
            print("DEFAULT")
            break
        }
    }
    

}
