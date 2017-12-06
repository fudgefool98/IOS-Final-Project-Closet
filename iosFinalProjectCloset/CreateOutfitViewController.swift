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
    
    var images = Image.createImages()
    var cellShirtStatus:NSMutableDictionary = NSMutableDictionary();
    var cellPantsStatus:NSMutableDictionary = NSMutableDictionary();
    var cellShoesStatus:NSMutableDictionary = NSMutableDictionary();
    
//    var shirtImages = Image.createItems(data: 0)
//    var pantsImages = Image.createItems(data: 1)
//    var shoesImages = Image.createItems(data: 2)
    
    var selectedShirtIndexPath: IndexPath?
    var selectedShoesIndexPath: IndexPath?
    var selectedPantsIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveOutfit(_ sender: Any) {
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let shirtCollectionView = self.shirtCollectionView,
        let pantsCollectionView = self.pantsCollectionView,
        let shoesCollectionView = self.shoesCollectionView {
            if let shirtIndexPath = shirtCollectionView.indexPathsForSelectedItems?.first,
            let shoesIndexPath = shoesCollectionView.indexPathsForSelectedItems?.first,
            let pantsIndexPath = pantsCollectionView.indexPathsForSelectedItems?.first {
                if let shirtCell = shirtCollectionView.cellForItem(at: shirtIndexPath) as? ShirtCollectionViewCell,
                let pantsCell = pantsCollectionView.cellForItem(at: pantsIndexPath) as? PantsCollectionViewCell,
                let shoesCell = shoesCollectionView.cellForItem(at: shoesIndexPath) as? ShoesCollectionViewCell {
                    if let shirtData = shirtCell.image,
                    let pantsData = pantsCell.image,
                    let shoesData = shoesCell.image {
                        let resultShirt = fetchItem(data: shirtData)
                        let resultPants = fetchItem(data: pantsData)
                        let resultShoes = fetchItem(data: shoesData)
                        
                        var _ = Outfit(shoes: resultShoes.first, shirt: resultShirt.first, pants: resultPants.first)
                        
                        do {
                            try managedContext.save()
                        } catch let error as NSError {
                            print("Could not save. \(error)")
                        }
                    }
                }
        }
       
        
        }
    }
    

    
    @IBAction func showTutorial(_ sender: Any) {
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

extension CreateOutfitViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
//        switch collectionView.tag {
//        case 0:
//            return shirtImages.count
//        case 1:
//            return pantsImages.count
//        default:
//            return shoesImages.count
//        }
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
            cell.image = self.images[indexPath.row]
            //cell.shirtImage.image = self.shirtImages[indexPath.row].photo
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.pantsIdentifier, for: indexPath as IndexPath) as! PantsCollectionViewCell
            cell.isSelected = (cellPantsStatus[indexPath.row] as? Bool) ?? false
            cell.image = self.images[indexPath.row]
            //cell.pantsImage.image = self.pantsImages[indexPath.row].photo
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.shoesIdentifier, for: indexPath as IndexPath) as! ShoesCollectionViewCell
            cell.isSelected = (cellShoesStatus[indexPath.row] as? Bool) ?? false
            cell.image = self.images[indexPath.row]
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

    
    
    func fetchItem(data: Image) -> [Item] {
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "photo == %@" , "\(String(describing: data))")
        
        let result = try? managedContext?.fetch(fetchRequest)
        let items = result as! [Item]
        return items
    }

    
    

    
}
