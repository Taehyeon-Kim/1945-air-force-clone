//
//  ViewController.swift
//  1945-shooting-game
//
//  Created by taehy.k on 2020/12/26.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    // MARK: - Variables
    var dragging: Bool = false
    var positionX: CGFloat!
    var positionY: CGFloat!
    
    var bones: [UIImageView] = []
    var monsters: [UIImageView] = []
    
    var isPaused: Bool = true
    var boneTimer: Timer!
    var monsterTimer: Timer!
    var checkTimer: Timer!

    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }

    
    // MARK: - View Variables
    var player: UIImageView = {
        let player = UIImageView(image: UIImage(named: "player"))
        
        player.frame = CGRect(x: 200, y: 800, width: 80, height: 80)
        
        return player
    }()
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(player)
        
        positionX = self.player.frame.origin.x + 19
        positionY = self.player.frame.origin.y - 10
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        
        // 뼈다귀 타이머
        DispatchQueue.global(qos: .background).async {
            self.boneTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                    
                    DispatchQueue.main.sync {
                        self.createBone()
                    }
                }
            
            RunLoop.current.run()
        }
        
        
        // 몬스터 타이머
        DispatchQueue.global(qos: .background).async {
            self.monsterTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    
                    DispatchQueue.main.sync {
                        self.createMonster()
                    }
                }
            
            RunLoop.current.run()
        }
        
        
        // 충돌(몬스터+뼈다귀) 체크 타이머
        DispatchQueue.global(qos: .background).async {
            self.checkTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
                    
                    DispatchQueue.main.sync {
                        self.checkCollision()
                    }
                }
            
            RunLoop.current.run()
        }
    }

    

    // MARK: - Touch Function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first!
        let touchPoint = touch.location(in: self.view)

        if player.frame.contains(touchPoint){
            dragging = true
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: self.view)

        if (self.dragging) {
            
            DispatchQueue.main.async {
                
                self.player.center = CGPoint(x: (touchPoint.x), y: (touchPoint.y))
                
                self.positionX = self.player.frame.origin.x + 19
                self.positionY = self.player.frame.origin.y - 10

            }
        
        }

    }

    
    // MARK: - Custom Function
    
    // 뼈다귀(총알) 생성 함수
    func createBone() {
        
        let bone = UIImageView(image: UIImage(named: "bone"))
        bone.frame = CGRect(x: self.positionX, y: self.positionY, width: 25, height: 25)
        bones.append(bone)
        
        
        // 애니메이션
        UIView.animate(withDuration: 1.5, delay: 0.0, options: .allowUserInteraction, animations: {
            bone.frame.origin.y = -200
            
        }, completion: {_ in
            if self.bones.contains(bone) {
                let index = self.bones.firstIndex(of: bone)
                self.bones.remove(at: index!)
                bone.removeFromSuperview()
            }
        })
    
        self.view.addSubview(bone)
    }

    
    
    // 몬스터 생성 함수
    func createMonster() {
        let monster = UIImageView(image: UIImage(named: "monster01"))
        monster.contentMode = .scaleAspectFill
        
        monsters.append(monster)

        let minValue = self.view.frame.size.width / 8
        let maxValue = self.view.frame.size.width - 20
        let createPoint = UInt32(maxValue - minValue)
        
        monster.frame = CGRect(x: CGFloat(arc4random_uniform(createPoint)), y: -50, width: 20, height: 70)
        
        
        // 애니메이션
        UIView.animate(withDuration: 5.0, delay: 0.0, options: .allowUserInteraction, animations: {
            monster.frame = CGRect(x: monster.frame.origin.x, y: 1000, width: 20, height: 70)
            
            
        }, completion: { _ in
            if self.monsters.contains(monster) {
                let index = self.monsters.firstIndex(of: monster)
                self.monsters.remove(at: index!)
                monster.removeFromSuperview()
            }
        })
        
        self.view.addSubview(monster)
    }
    
    // 뼈다귀 + 몬스터 충돌 여부 체크 함수
    func checkCollision() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                if self.bones.count > 0 {
                    if self.monsters.count > 0 {
                        
                        for bone in self.bones {
                            
                            for monster in self.monsters {

                                if let monsterVal = monster.layer.presentation()?.frame, let boneVal = bone.layer.presentation()?.frame {
                                    
                                    
                                    if monsterVal.intersects(self.player.frame) {
                                        
                                        if let gameOverVC = self.storyboard?.instantiateViewController(identifier: "GameOverViewController") as? GameOverViewController{

                                            self.pause()

                                            gameOverVC.paramScore = self.score
                                            gameOverVC.modalTransitionStyle = .coverVertical
                                            gameOverVC.modalPresentationStyle = .fullScreen
                                            self.present(gameOverVC, animated: true, completion: nil)
                                            
                                            self.score = 0

                                        }
                                        
                                        
                                    }
                                    

                                    if monsterVal.intersects(boneVal) {
                                        
                                        let index = self.monsters.firstIndex(of: monster)
                                        self.monsters.remove(at: index!)
                                        monster.removeFromSuperview()
                                        
                                        self.score += 30
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func pause() {
        
        boneTimer.invalidate()
        monsterTimer.invalidate()
        checkTimer.invalidate()
        
    }
    

    
    
}

