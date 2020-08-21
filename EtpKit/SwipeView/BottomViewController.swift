//
//  BottomViewController.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 15.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


class BottomViewController: UIViewController {
    
    
    private var imageHistoryObserver: NSKeyValueObservation?
    
    @IBOutlet weak var etpPhotoViewer: EtpPhotoViewer!
    @IBOutlet weak var imageView: UIImageView!
    private var barHeight:CGFloat = 132
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        
        
        etpPhotoViewer.etpDelegate = self
        etpPhotoViewer.maxItemCount = 20
        
        
        
        
        imageHistoryObserver = UserDefaults.standard.observe(\.imageHistory, options: [.new, .initial,.old]) { (defaults, change) in
            
            self.etpPhotoViewer.removeAll()
            
            defaults.imageHistory.forEach{ mUrl in
                
                _ = self.etpPhotoViewer.addPhoto(PhotoViewerModel(photo: mUrl))
            }
        }
        
        
    }
    @objc func rotated() {
        barHeight = self.navigationController!.navigationBar.frame.height + 44 + UIApplication.statusBarHeight
        //log.i(tag: "Bar Height", msg: "\(barHeight)")
        closeStateAnim()
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        
        let y = self.view.frame.minY
        let maxY = self.view.frame.maxY
        if y <= 0 {
            
            self.view.frame = CGRect.init(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            
        }
        
        if(recognizer.state == .ended)
        {
            if maxY < UIScreen.main.bounds.height / 2 {
                closeStateAnim()
                
            }else{
                openStateAnim()
            }
            
        }
        recognizer.setTranslation(.zero, in: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        closeStateAnim()
    }
    func openStateAnim(){
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent:CGFloat = 0
            self?.view.frame = CGRect.init(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
            self?.imageView.image = UIImage.init(systemName: "chevron.up")
            
        }
    }
    func closeStateAnim(){
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent:CGFloat = (UIScreen.main.bounds.height * -1) + self!.barHeight
            self?.view.frame = CGRect.init(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
            self?.imageView.image = UIImage.init(systemName: "chevron.down")
        }
    }
    
}

extension BottomViewController : EtpPhotoViewerDelagete{
    func onAction(model: PhotoViewerModel) {
        let snackbar = TTGSnackbar(
            message: "1 Fotoğraf Silindi",
            duration: .middle,
            actionText: "Geri Al",
            actionBlock: { (snackbar) in
                
                UserDefaults.Image.add(url: model.photo!)
        }
        )
        
        
        UserDefaults.Image.remove(url: model.photo!)
        snackbar.icon = UIImage(systemName:  "trash")
        snackbar.iconTintColor = .white
        snackbar.show()
    }
    
    
    func onTab(model: PhotoViewerModel) {
        let alert = EtpAlertController(icon: nil,title: "Tıklandı", message: model.photo , preferredStyle: .actionSheet)
        alert.addAction(EtpAlertAction(title: "Tamam",style: .default))
        alert.addAction(EtpAlertAction(title: "İptal",style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onAdd() {
        view.endEditing(true)
        
        let photoUrl =  "https://randomuser.me/api/portraits/women/\(Int.random(in: 1 ..< 100)).jpg"
        UserDefaults.Image.add(url: photoUrl)
        
        
    }
    
    
}


extension UIApplication {
    static var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = shared.windows.filter { $0.isKeyWindow }.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
