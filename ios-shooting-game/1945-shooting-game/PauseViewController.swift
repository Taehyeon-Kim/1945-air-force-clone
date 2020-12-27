//
//  PauseViewController.swift
//  1945-shooting-game
//
//  Created by taehy.k on 2020/12/26.
//

import UIKit

class PauseViewController: UIViewController {
    
    // MARK: - IBOutlet

    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - IBAction
    @IBAction func continueButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func quitButtonClicked(_ sender: Any) {
        
        let alertVC = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
        
            self.unwindToIntro()
            
        })
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true, completion: nil)
        
    }
    
    func unwindToIntro() {
        performSegue(withIdentifier: "unwindToIntro", sender: self)
    }
}
