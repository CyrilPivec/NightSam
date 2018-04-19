//
//  GalerieView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 05/07/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class GalerieView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var _id = String()
    var photos = [String]()
    
    @IBOutlet var _collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self._collection.delegate = self
        self._collection.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! GalerieViewCell
        
        if let checkedUrl = URL(string: baseUrl + photos[indexPath.row] ) {
            cell._image.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: cell._image )
        }
        
        return cell
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, image: UIImageView) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                image.image = UIImage(data: data)
            }
        }
    }
    
}
