//
//  ETPImageView.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 17.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit
@IBDesignable
class ETPImageView: UIImageView {
    
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue < frame.height / 2 ? newValue : frame.height / 2
        }
    }
    
    
    lazy var indicator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.color = .white
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        backgroundColor = .lightGray
        addSubview(indicator)
        
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      
 
    }
    
    
    func loadImageFrom(path:String?,placeholder: UIImage? = nil){
        
        image = placeholder
        guard let link = path else { return }
        guard let url = URL(string: link) else { return }
        self.indicator.startAnimating()
      
        
        
        if let imageFromCache = imageCache.object(forKey: link as AnyObject) as? UIImage {
            self.image = imageFromCache
            self.indicator.stopAnimating()
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                log.e(tag: "UIImageView.loadImageFrom", msg: "Resim Yüklenemedi")
            }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                let imageToChache = UIImage(data: data)
                imageCache.setObject(imageToChache!, forKey: link as AnyObject)
                self.image = image
                self.indicator.stopAnimating()
            }
        }.resume()
        
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
      func loadImage(path:String?,placeholder: UIImage? = nil){
          
          image = placeholder
          guard let link = path else { return }
          guard let url = URL(string: link) else { return }
        
          
          
          if let imageFromCache = imageCache.object(forKey: link as AnyObject) as? UIImage {
              self.image = imageFromCache
              return
          }
          URLSession.shared.dataTask(with: url) { (data, response, error) in
              
              if error != nil{
                  log.e(tag: "UIImageView.loadImageFrom", msg: "Resim Yüklenemedi")
              }
              guard
                  let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
                  else { return }
              DispatchQueue.main.async() { () -> Void in
                  let imageToChache = UIImage(data: data)
                  imageCache.setObject(imageToChache!, forKey: link as AnyObject)
                  self.image = image
              }
          }.resume()
          
      }
}
