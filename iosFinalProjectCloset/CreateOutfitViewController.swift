//
//  CreateOutfitViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/16/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//


//
import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveOutfit(_ sender: Any) {
        
        
        
        
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

extension CreateOutfitViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
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
            cell.image = self.images[indexPath.row]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.pantsIdentifier, for: indexPath as IndexPath) as! PantsCollectionViewCell
            cell.image = self.images[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.shoesIdentifier, for: indexPath as IndexPath) as! ShoesCollectionViewCell
            cell.image = self.images[indexPath.row]
            return cell
            
        }
        
        
    }
    

    
    

    
}
