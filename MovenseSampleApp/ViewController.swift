//
//  ViewController.swift
//  MovenseSampleApp
//
//  Created by Bunty Kumar on 05/03/18.
//  Copyright © 2018 Bunty Kumar. All rights reserved.
//

import UIKit
import MovenseCamera
import CoreMotion
var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
class ViewController: UIViewController,DownloadProgrssDelegate,MovesCountDelegate {
    var movesCount: Int = 0 {
        didSet{
            DispatchQueue.main.async {
                self.movesCountLabel.text = "\(self.movesCount)"
            }
    }
    }
    
    var progress: Double = 0.0 {
        didSet{
            print("self.progress\(self.progress)")
            DispatchQueue.main.async {
                self.progressLabel.text = "\(Int(self.progress * 100))"
                if self.progress >= 1.0{
                    self.progressLabel.isHidden = true
                    self.progressLabelHead.isHidden = true
                }
            }
            
        }
    }
    @IBOutlet weak var movesCountLabel: UILabel!
    @IBOutlet weak var moveImageView: Move!
    @IBOutlet weak var progressLabelHead: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    let motionManger = CMMotionManager()
    var url = "https://www.movense.com/publisher/moves/5_509.move"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.moveImageView?.downladProgressDelegate = self
        self.moveImageView.movesCountDelegate = self
        self.moveImageView.moveDownload(downloadURL: URL(string: url)!, moveName: "", filePath: documentsDirectory.absoluteString)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        moveImageView.stopMotionUpdates()
        print("back")
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
}

