//
//  VideoController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 01.06.2021.
//

import UIKit
import youtube_ios_player_helper

class VideoController: UIViewController {

    @IBOutlet weak var segmentedButton: UISegmentedControl!
    @IBOutlet weak var trailerView: UIView!
    @IBOutlet weak var filmView: UIView!
    @IBOutlet weak var playerView : YTPlayerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentedAction(_ sender: Any) {
        
        if trailerView.isHidden {
            trailerView.isHidden = false
            filmView.isHidden = true
        }else{
            filmView.isHidden = false
            trailerView.isHidden = true
        }
    }
}
