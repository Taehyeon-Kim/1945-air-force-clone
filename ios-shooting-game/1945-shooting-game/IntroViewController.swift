//
//  IntroViewController.swift
//  1945-shooting-game
//
//  Created by taehy.k on 2020/12/26.
//

import UIKit
import IntroScreen

class IntroViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        playButton.layer.cornerRadius = 8
        playButton.layer.borderWidth = 3
        playButton.layer.borderColor = CGColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1)
        
        howToPlayButton.layer.borderWidth = 3
        howToPlayButton.layer.cornerRadius = 8
        howToPlayButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    @IBAction func unwind (_ seg : UIStoryboardSegue) {
    }
    
    
}
