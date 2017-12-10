//
//  ViewOutfitViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class ViewOutfitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outfitTable: UITableView!
    var outfits:[Outfit] = []
    var images:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Outfit> = Outfit.fetchRequest()
        
        do {
            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                outfits = (try managedContext.fetch(fetchRequest)) ?? []
                //items = (try managedContext.fetch(fetchRequest)) ?? []
            }
            
        } catch {
            print(error)
            return
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
        print(outfits.count)
        return outfits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //chosenOutfit = outfits[indexPath.row]
        
       

    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let identifier = segue.identifier else {return }
//
//        switch identifier {
//        case "showOutfit":
//            if let navController = segue.destination as? UINavigationController, let destination = navController.viewControllers.first as? CreateOutfitViewController {
//                if let shirt = chosenOutfit.shirt?.photo, let pants = chosenOutfit.pants?.photo, let shoes = chosenOutfit.shoes?.photo {
//                    destination.shirtCollectionView = shirt
//                    destination.pantsCollectionView = pants
//                    destination.shoesCollectionView = shoes
//                }
//            }
//        default:
//            break
//        }
//    }
    


}
