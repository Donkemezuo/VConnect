//
//  NGOsCategoriesViewController.swift
//  VConnect
//
//  Created by Donkemezuo Raymond Tariladou on 5/24/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class NGOsCategoriesViewController: UIViewController {
    
    private var nGOCategories = ["Domestic Violence", "Child issues", "Sexual Assault", "Human Rights", "Women", "Youth Development", "Education", "Homelessness", "Leadership", "Economic Development"]
    
    private var nGOs = [NGO](){
        didSet {
            DispatchQueue.main.async {
                self.nGOsView.categoriesCollectionView.reloadData()
            }
        }
    }
    
    private var nGOsView = NGOsCategoriesView()
    
    private var nGOsInCategory = [String:[NGO]]()

    override func viewDidLoad() {
        super.viewDidLoad()
 view.backgroundColor = UIColor.init(hexString: "033860")
 navigationItem.title = "Home"
        view.addSubview(nGOsView)
 nGOsView.categoriesCollectionView.delegate = self
 nGOsView.categoriesCollectionView.dataSource = self
        fetchNGOs()
    }
    
    private func fetchNGOs(){
 DataBaseService.firestoreDataBase.collection(NGOsCollectionKeys.ngoCollectionKey).addSnapshotListener(includeMetadataChanges: true) {[weak self] (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                var nGOs = [NGO]()
                for document in querySnapshot.documents {
                    let nGO = NGO.init(dict: document.data())
                    nGOs.append(nGO)
                    if var foundNGOArray = self?.nGOsInCategory[nGO.ngoCategory] {
                        foundNGOArray.append(nGO)
                    } else {
                        self?.nGOsInCategory[nGO.ngoCategory] = [nGO]
                        
                    }
                }
                
                self?.nGOs = nGOs
            } else if let error = error {
                
                self?.showAlert(title: "Error", message: "Error: \(error.localizedDescription) encountered while fetching NGOs")
            }
        }
    }
    

}

extension NGOsCategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nGOCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else {return UICollectionViewCell()}
        let category = nGOCategories[indexPath.row]
        categoriesCell.categoryNameLabel.text = category
        categoriesCell.categoryNameLabel.textAlignment = .center
        categoriesCell.layer.borderWidth = 2
        categoriesCell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return categoriesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedNGOCategory = nGOCategories[indexPath.row]
        let nGOsInSelectedCategory = nGOs.filter{$0.ngoCategory == selectedNGOCategory}
        let destinationViewController = NGOsViewController(nGOsInCategory: nGOsInSelectedCategory)
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
}
