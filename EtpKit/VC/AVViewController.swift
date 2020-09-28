//
//  AVViewController.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 23.08.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit
import AVKit

class AVViewController: UIViewController {

    @IBOutlet var videoLayer: UIView!
    let url = "https://www780.o0-2.com/token=0yQqeSkA89WhR6eybhPOAw/1598198844/78.190.0.0/73/6/b1/1a976278e8dcc070a8053774666cfb16-480p.mp4"
    override func viewDidLoad() {
        super.viewDidLoad()
        let player = AVPlayer(url: URL(string: url)!)
        let playerLayer = AVPlayerLayer(player: player)
        
        self.videoLayer.layer.addSublayer(playerLayer)
        //playerLayer.frame = self.videoLayer.frame
        playerLayer.frame =   CGRect(x: 0, y: 0, width: videoLayer.layer.frame.width,height: videoLayer.layer.frame.height)
        
        
        player.play()
    }
    


}
