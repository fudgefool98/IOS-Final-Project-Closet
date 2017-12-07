//
//  EditItemViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData


class EditItemViewController: UIViewController {
   
    @IBOutlet weak var itemPhoto: UIImageView? 
    @IBOutlet weak var editClothing: UISegmentedControl!
    @IBOutlet weak var editWeather: UISegmentedControl!
    @IBOutlet weak var editFormal: UISegmentedControl!
    
    @IBAction func saveItem(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let _ = Item(category: Int64(editClothing.selectedSegmentIndex), formalTag: Int64(editFormal.selectedSegmentIndex), photo: itemPhoto?.image, weatherTag: Int64(editWeather.selectedSegmentIndex))
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func deleteItem(_ sender: Any) {
        //var photo = itemPhoto?.image
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "photo == %@ AND category == %@ AND weatherTag == %@ AND formalTag == %@" , "\(String(describing: itemPhoto))", "\(editClothing)", "\(editWeather)", "\(editFormal)")
        
        let result = try? managedContext?.fetch(fetchRequest)
        let resultData = result as! [Item]
        
        for object in resultData {
            managedContext?.delete(object)
        }
        
        do {
            try managedContext?.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error)")
        } catch {
            
        }
    }
    
    
    var photo: UIImage? {
        didSet {
            self.itemPhoto?.image = photo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPhoto?.image = photo
        // Do any additional setup after loading the view.
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
