//
//  ViewController.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 29.03.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var imageHistoryObserver: NSKeyValueObservation?
    let messageText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui.Lorem ipsum dolor sit amet, consectetur adipiscing elit. In mauris nulla, luctus non convallis sit amet, interdum id tortor. Vivamus non lacinia arcu. Pellentesque vitae elit dui. "
    
    
    
    @IBOutlet weak var etpPhotoViewer: EtpPhotoViewer!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dummyView: UIView!
    @IBOutlet weak var etpImageView: ETPImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: .Didot, type: .Bold, size: 17)!]
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        addBottomSheetView()
        
        
        
        
        titleLabel.font = UIFont.init(name:.Helvetica, type: .Bold, size: 12)
        titleLabel.text = "Emin Tolgahan polat"//UserDefaults.standard.username
        
        etpImageView.onClick{
            self.titleLabel.text = "Tıklandı"

          self.etpImageView.loadImageFrom(path: "https://randomuser.me/api/portraits/women/\(Int.random(in: 1 ..< 100)).jpg", placeholder: UIImage(named: "a"))
            
        }
        
        
        etpImageView.onDoubleClick {
            self.titleLabel.text = "Double Tıklandı"
             self.etpImageView.loadImageFrom(path: nil, placeholder: UIImage(named: "a"))
        }
        
        etp.detectScreenShot {
            
            self.titleLabel.text = "ScrenShot"
           
        }
        
        
        
        etpPhotoViewer.etpDelegate = self
        etpPhotoViewer.maxItemCount = 6
        
        
        imageHistoryObserver = UserDefaults.standard.observe(\.imageHistory, options: [.new, .initial,.old]) { (defaults, change) in
            guard let newValue = change.newValue else { return }
            self.etpPhotoViewer.removeAll()
            newValue.forEach{ mUrl in
                
                _ = self.etpPhotoViewer.addPhoto(PhotoViewerModel(photo: mUrl))
               
            }
        }
        
    }
    
    @IBAction func alertAction(_ sender: Any) {
        
      //  let alert = EtpAlertController(icon: UIImage(systemName: "info.circle") ,title: "Alert", message: messageText , preferredStyle: //.alert)
      //  alert.imageView.tintColor = .orange
      //  //alert.isCancelable = false
      //  //alert.isVerticalButton = true
      //  alert.addAction(EtpAlertAction(title: "Tamam", style: .default,handler:{
      //
      //      print("Tıklandı")
      //  }))
      //  alert.addAction(EtpAlertAction(title: "İptal", style: .cancel))
      //  alert.addAction(EtpAlertAction(title: "Sil", style: .destructive))
      //  self.present(alert, animated: true, completion: nil)
        
        
    }
    var bottomSheetVC : BottomViewController? = nil
    func addBottomSheetView() {
        if bottomSheetVC == nil {
            // 1- Init bottomSheetVC
            bottomSheetVC = BottomViewController()
            // 2- Add bottomSheetVC as a child view
            self.addChild(bottomSheetVC!)
            self.view.addSubview(bottomSheetVC!.view)
            bottomSheetVC!.didMove(toParent: self)
            
            // 3- Adjust bottomSheet frame and initial position.
            let height = view.frame.height
            let width  = view.frame.width
            bottomSheetVC!.view.frame = CGRect.init(x: 0, y: self.view.frame.maxY * -1 , width: width, height: height)
        }
    }
    
}

extension ViewController : EtpPhotoViewerDelagete{
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
        
        
        let alert = EtpAlertController(icon: nil,title: "Tıklandı", message: messageText , preferredStyle: .actionSheet)
        alert.addAction(EtpAlertAction(title: "Tamam",style: .default))
        alert.addAction(EtpAlertAction(title: "İptal",style: .cancel))
        
        alert.addAction(EtpAlertAction(title: "Sil",style: .destructive))
        alert.addAction(EtpAlertAction(title: "Sil",style: .destructive))
        alert.addAction(EtpAlertAction(title: "Sil",style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onAdd() {
        view.endEditing(true)
        
        let photoUrl =  "https://randomuser.me/api/portraits/women/\(Int.random(in: 1 ..< 100)).jpg"
        UserDefaults.Image.add(url: photoUrl)
        
        
    }
    
    
}



extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
