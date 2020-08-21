//
//  EtpPhotoViewer.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 29.03.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


protocol EtpPhotoViewerDelagete {
    func onAdd()
    func onTab(model: PhotoViewerModel)
    func onAction(model: PhotoViewerModel)
}

class EtpPhotoViewer : UICollectionView {
    var longPressGesture : UILongPressGestureRecognizer!
    var etpDelegate:EtpPhotoViewerDelagete?
    
    private let isMoveable = true
    var maxItemCount = 6
    var rowCount:CGFloat = 3
    private var cellSize :CGFloat  = 0
    var data:[PhotoViewerModel] = []
    
    func removeAll(){
        data.removeAll()
        self.reloadData()
    }
    func setPhotos(_ datas : [PhotoViewerModel]) -> Bool{
        if self.data.count < maxItemCount{
            self.data.append(contentsOf: data)
            self.reloadData()
            return true
        }else {
            return false
        }
        
    }
    
    func addPhoto(_ data : PhotoViewerModel) -> Bool{
        if self.data.count < maxItemCount{
            self.data.append(data)
            self.reloadData()
            return true
        }else {
            return false
        }
        
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    
    
    
    
    func setupView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.cellSize =  bounds.width / rowCount
        
      
        self.dataSource = self
        self.delegate = self
        self.register(PhotoViewerViewCell.nib, forCellWithReuseIdentifier: PhotoViewerViewCell.identifier)
        self.alwaysBounceVertical = false
        self.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        addGestureRecognizer(longPressGesture)
       
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {

          switch(gesture.state) {
              
          case .began:
              guard let selectedIndexPath = indexPathForItem(at: gesture.location(in: self)) else {
                  break
              }
             beginInteractiveMovementForItem(at: selectedIndexPath)
          case .changed:
              updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
          case .ended:
              endInteractiveMovement()
          default:
             cancelInteractiveMovement()
          }
    }
    
    @objc func rotated() {
        self.cellSize =  bounds.width / rowCount
        self.reloadData()
    }
    
}
extension EtpPhotoViewer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.data.count < maxItemCount ? self.data.count + 1 : self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewerViewCell.identifier, for: indexPath) as! PhotoViewerViewCell
        /**
         if self.data.count < maxItemCount  {
         if indexPath.row == 0 {
         cell.setup(photoViewerModel: PhotoViewerModel(photo: nil) )
         cell.photoView.isUserInteractionEnabled = true
         cell.photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
         }else {
         cell.photoView.isUserInteractionEnabled = false
         cell.setup(photoViewerModel: data[indexPath.row - 1] )
         cell.actionButton.tag = indexPath.row - 1
         cell.actionButton.addTarget(self, action: #selector(removeAction), for: .touchUpInside)
         
         }
         }else {
         cell.photoView.isUserInteractionEnabled = false
         cell.setup(photoViewerModel: data[indexPath.row] )
         cell.actionButton.tag = indexPath.row
         cell.actionButton.addTarget(self, action: #selector(removeAction), for: .touchUpInside)
         }
         cell.photoView.cornerRadius(radius: 12)
         */
        
        if self.data.count < maxItemCount  {
            if indexPath.row == self.data.count {
                cell.setup(photoViewerModel: PhotoViewerModel(photo: nil) )
                cell.photoView.onClick {
                    self.etpDelegate?.onAdd()
                }
            }else {
                cell.setup(photoViewerModel: data[indexPath.row ] )
                cell.photoView.onClick {
                    self.etpDelegate?.onTab(model: self.data[indexPath.row])
                }
                
                
                cell.actionButton.onClick {
                    if indexPath.row < self.data.count {
                        self.etpDelegate?.onAction(model: self.data[indexPath.row])
                        self.deleteItems(at: [indexPath])
                    }
                }
            }
        }else {
            cell.setup(photoViewerModel: data[indexPath.row] )
            
            cell.photoView.onClick {
                self.etpDelegate?.onTab(model: self.data[indexPath.row])
            }
            
            cell.actionButton.onClick {
                self.etpDelegate?.onAction(model: self.data[indexPath.row])
                self.deleteItems(at: [indexPath])
            }
        }
        
        return cell
    }
}



extension EtpPhotoViewer: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize , height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       print("Starting Index: \(sourceIndexPath.item)")
       print("Ending Index: \(destinationIndexPath.item)")
    
        
        let mData = self.data[sourceIndexPath.item]
        self.data.remove(at: sourceIndexPath.item)
        self.data.insert(mData, at: destinationIndexPath.item)
        self.reloadData()
    }
}
