//
//  PhotoViewerViewCell.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 29.03.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


struct PhotoViewerModel {
    let photo:String?
}
class PhotoViewerViewCell: UICollectionViewCell {
    static var identifier: String = "PhotoViewerViewCell"
    static let nib = UINib.init(nibName: "PhotoViewerViewCell", bundle: nil)
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var isEditable = true

    func setup(photoViewerModel: PhotoViewerModel ){
     
        indicator.isHidden = true
        actionButton.tintColor = .gray
        photoView.contentMode = .scaleAspectFill
        photoView.cornerRadius(radius: 12)
        photoView.image = nil
        if photoViewerModel.photo == nil{
            actionButton.isHidden = true
            photoView.backgroundColor = .lightGray
            photoView.image = UIImage(systemName: "plus")
            photoView.tintColor = .white
            photoView.contentMode = .center
        }else{
            if isEditable {
                actionButton.isHidden = false
            }else{
                actionButton.isHidden = true
            }
            photoView.tag = Int.random(in: 100..<999)
            if let path =  photoViewerModel.photo{
                photoView.loadImage(path: path)
            }
            
        }
    }
    
    
    
    
    private func loadImage(path: String) {
        if let url =  URL(string: path){
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.indicator.isHidden = true
                            self?.indicator.stopAnimating()
                            self?.photoView.image = image
                        }
                    }
                }
            }
        }
    }
}

private extension UIImageView {
    
    
    func cornerRadius(radius:CGFloat){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
