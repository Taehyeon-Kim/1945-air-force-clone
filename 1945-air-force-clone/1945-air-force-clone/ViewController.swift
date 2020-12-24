//
//  ViewController.swift
//  1945-air-force-clone
//
//  Created by taehy.k on 2020/12/24.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: - variables for view
    var playerView: UIImageView = {
        let playerView = UIImageView(image: UIImage(named: "jet"))
        playerView.image = UIImage(named: "jet")
        playerView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        playerView.center = CGPoint( // playerView의 가운데가 중심점이 되어 이동한다!!
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 1.1
        )
        return playerView
    }()
    
    var bTimer: Timer?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(createBullets), userInfo: nil, repeats: true)
        
        self.view.addSubview(playerView) // 여기서 view는 ViewController가 가지고 있는 view!!
        
        // 이미지 뷰의 경우 이를 true로 설정해주지 않으면, 드래그가 작동하지 않는다. 뷰의 경우만 기본 값이 true
        playerView.isUserInteractionEnabled = true
        
        // UIPanGestureRecognizer는 target(ViewController)에서 drag가 감지되면 action을 실행한다.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        
        // panGesture가 보는 view는 playerView가 된다.
        playerView.addGestureRecognizer(panGesture)
        

    }


    // MARK: - Custom Function
    // #select가 objective-c 문법이기 때문에 앞에 annotation(@)objc를 붙인다
    @objc func drag(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view) // translation에 움직인 위치를 저장한다.

        // sender의 view는 sender가 바라보고 있는 playerView이다. 드래그로 이동한 만큼 playerView를 이동시킨다.
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        sender.setTranslation(.zero, in: self.view) // 0으로 움직인 값을 초기화 시켜준다.
    }

    // 총알 생성 함수
    @objc func createBullets() {
        let bulletView = UIImageView(image: UIImage(named: "bullet"))
        bulletView.frame = CGRect(x: playerView.frame.origin.x + 12.5, y: playerView.frame.origin.y - 12, width: 25, height: 25)
        UIView.animate(withDuration: 0.6, animations: {
            bulletView.frame = CGRect(x: self.playerView.frame.origin.x + 12.5, y: -150, width: 30, height: 30)
        })
        self.view.addSubview(bulletView)
    }
}

