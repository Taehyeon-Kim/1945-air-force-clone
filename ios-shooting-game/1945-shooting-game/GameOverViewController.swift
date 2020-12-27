//
//  GameOverViewController.swift
//  1945-shooting-game
//
//  Created by taehy.k on 2020/12/26.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var totalScore: UILabel!
    
    var paramScore: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.totalScore.text = String(self.paramScore)
    }

    @IBAction func retryButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func quitButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindToIntro", sender: self)
    }
}
