//
//  CreateOutfitViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/16/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//


//
import UIKit
import CoreData

class CreateOutfitViewController: UIViewController{

    @IBOutlet weak var shirtCollectionView: UICollectionView!
    @IBOutlet weak var pantsCollectionView: UICollectionView!
    @IBOutlet weak var shoesCollectionView: UICollectionView!

    @IBOutlet weak var shoesFormalSegment: UISegmentedControl!
    @IBOutlet weak var pantsFormalSegment: UISegmentedControl!
    @IBOutlet weak var shirtFormalSegment: UISegmentedControl!
    @IBOutlet weak var shoesWeatherSegment: UISegmentedControl!
    @IBOutlet weak var pantsWeatherSegment: UISegmentedControl!
    @IBOutlet weak var shirtWeatherSegment: UISegmentedControl!
    
    var images: [Image] = []
    var items: [Item] = []
    var cellShirtStatus:NSMutableDictionary = NSMutableDictionary();
    var cellPantsStatus:NSMutableDictionary = NSMutableDictionary();
    var cellShoesStatus:NSMutableDictionary = NSMutableDictionary();

    var selectedShirtIndexPath: IndexPath?
    var selectedShoesIndexPath: IndexPath?
    var selectedPantsIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                items = (try managedContext.fetch(fetchRequest)) ?? []
            }
            
        } catch {
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveOutfit(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
  
            let shirtCell = items.filter({ $0.category == 0 })[(selectedShirtIndexPath?.row)!]
            let pantsCell = items.filter({ $0.category == 1 })[(selectedPantsIndexPath?.row)!]
            let shoesCell = items.filter({ $0.category == 2 })[(selectedShoesIndexPath?.row)!]
        
                        var _ = Outfit(shoes: shoesCell, shirt: shirtCell, pants: pantsCell)

                        do {
                            try managedContext.save()
                        } catch let error as NSError {
                            print("Could not save. \(error)")
                        }
        
    }
    
    @IBAction func showTutorial(_ sender: Any) {

    }

}

extension CreateOutfitViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return items.filter({ $0.category == 0 }).count
        case 1:
            return items.filter({ $0.category == 1 }).count
        default:
            return items.filter({ $0.category == 2 }).count
        }
    }
    
    private struct Storyboard {
        static let shirtIdentifier = "shirtCell"
        static let shoesIdentifier = "shoeCell"
        static let pantsIdentifier = "pantCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.shirtIdentifier, for: indexPath as IndexPath) as! ShirtCollectionViewCell
            cell.isSelected = (cellShirtStatus[indexPath.row] as? Bool) ?? false
            cell.image = Image(image: items.filter({ $0.category == 0 })[indexPath.row].photo)
            //cell.shirtImage.image = self.shirtImages[indexPath.row].photo
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.pantsIdentifier, for: indexPath as IndexPath) as! PantsCollectionViewCell
            cell.isSelected = (cellPantsStatus[indexPath.row] as? Bool) ?? false
            cell.image = Image(image: items.filter({ $0.category == 1 })[indexPath.row].photo)
            //cell.pantsImage.image = self.pantsImages[indexPath.row].photo
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.shoesIdentifier, for: indexPath as IndexPath) as! ShoesCollectionViewCell
            cell.isSelected = (cellShoesStatus[indexPath.row] as? Bool) ?? false
            cell.image = Image(image: items.filter({ $0.category == 2 })[indexPath.row].photo)
            //cell.shoesImage.image = self.shoesImages[indexPath.row].photo
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case 0:
            if let selectedShirtIndexPath = self.selectedShirtIndexPath {
                let cell = shirtCollectionView.cellForItem(at: selectedShirtIndexPath)
                cell?.isSelected = true;
                self.cellShirtStatus[indexPath.row] = true;
                cell?.isSelected = false
                collectionView.deselectItem(at: selectedShirtIndexPath, animated: true)
            }
            
            self.selectedShirtIndexPath = indexPath
        case 1:
            if let selectedPantsIndexPath = self.selectedPantsIndexPath {
                let cell = pantsCollectionView.cellForItem(at: selectedPantsIndexPath)
                cell?.isSelected = true;
                self.cellPantsStatus[indexPath.row] = true;
                cell?.isSelected = false
                collectionView.deselectItem(at: selectedPantsIndexPath, animated: true)
            }
            
            self.selectedPantsIndexPath = indexPath
        default:
            if let selectedShoesIndexPath = self.selectedShoesIndexPath {
                let cell = shoesCollectionView.cellForItem(at: selectedShoesIndexPath)
                cell?.isSelected = true;
                self.cellShoesStatus[indexPath.row] = true;
                cell?.isSelected = false
                collectionView.deselectItem(at: selectedShoesIndexPath, animated: true)
            }
            
            self.selectedShoesIndexPath = indexPath
        }
    }

}
