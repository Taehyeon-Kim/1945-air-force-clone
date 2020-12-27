//
//  HowToPlayViewController.swift
//  1945-shooting-game
//
//  Created by taehy.k on 2020/12/27.
//

import UIKit
import IntroScreen

class HowToPlayViewController: UIViewController {

    
    private let backgroundImages: [String] = [ "intro01",
                                               "intro02",
                                               "intro03" ]
    
    private let ments: [String] = [ "01. You can move character using touch!",
                                    "02. If you hit the monster with a bone, the score will go up!",
                                    "03. The game ends when the player touches the monster." ]
    
    private let pageViewController = UIPageViewController(transitionStyle: .pageCurl,
                                                          navigationOrientation: .horizontal)
    //  인디케이터로 사용할 페이지 컨트롤입니다
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .red   // 현재 페이지 인디케이터 색
        pc.pageIndicatorTintColor = .white        // 나머지 페이지 인디케이터 색
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setPageViewController()
        setPageControl()
    }

    //  컨텐츠 뷰컨을 만들어주는 메서드를 따로 만들어줬습니다
    //  그냥 뷰컨 하나를 생성하고 태그에 인덱스 번호를 넣어주고 배경색만 바꿔줬습니다
    private func instantiateViewController(index: Int, image: String, ment: String) -> UIViewController {
        let vc = UIViewController()
        let backgroundImage = UIImageView()
        let transparentView = UIView()
        let label = UILabel()
        let quitButton = UIButton(type: .custom)
        
        // 배경
        backgroundImage.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        backgroundImage.image = UIImage(named: image)
        
        // 불투명 배경
        transparentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        // 라벨
        label.text = ment
        label.font = UIFont(name: "Marker Felt", size: 24)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layoutMargins = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        // 나가기 버튼
        quitButton.setImage(UIImage(named: "cancel"), for: .normal)
        quitButton.tintColor = .white
        quitButton.addTarget(self, action: #selector(quitButtonClicked), for: .touchUpInside)
   
        // 하위 뷰에 추가
        vc.view.tag = index
        vc.view.addSubview(backgroundImage)
        vc.view.addSubview(transparentView)
        vc.view.addSubview(label)
        vc.view.addSubview(quitButton)
        

        // 불투명 배경 오토레이아웃
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        transparentView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        transparentView.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        
        // 배경 이미지 오토레이아웃
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        
        // 설명 멘트 오토레이아웃
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -20).isActive = true
        
        // 버튼 오토레이아웃
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        quitButton.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -20).isActive = true
        quitButton.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 70).isActive = true
        quitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        quitButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        return vc
    }
    
    private func setPageViewController() {
        //  데이터소스와 델리게이트로 부모 뷰컨을 설정해줍니다
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        //  처음에 보여줄 컨텐츠 설정
        let firstVC = instantiateViewController(index: 0, image: backgroundImages[0], ment: ments[0])
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
        //  페이지 뷰컨을 부모 뷰컨에 띄워줍니다
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    private func setPageControl() {
        //  페이지 컨트롤에 전체 페이지 수를 설정해줍시다
        pageControl.numberOfPages = backgroundImages.count
        
        //  그리고 페이지 컨트롤을 화면에 띄워주면 됩니다
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func quitButtonClicked(sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }

}

extension HowToPlayViewController: UIPageViewControllerDataSource {

    //  이전 컨텐츠 뷰컨을 리턴해주시면 됩니다
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        
        //  컨텐츠 뷰컨을 생성할 때 태그에 인덱스를 넣어줬기 때문에 몇번째 페이지인지 바로 알 수 있어요
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        
        // 이전 인덱스를 계산해주고요
        let nextIndex = index > 0 ? index - 1 : backgroundImages.count - 1
        
        // 이전 컨텐츠를 담은 뷰컨을 생성해서 리턴해줍니다
        let nextVC = instantiateViewController(index: nextIndex, image: backgroundImages[nextIndex], ment: ments[nextIndex])
        return nextVC
    }
    
    //  다음 컨텐츠 뷰컨을 리턴해주시면 됩니다. 위에 메서드랑 똑같은데 다음 컨텐츠를 담으면 돼요
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        let nextIndex = (index + 1) % backgroundImages.count
        let nextVC = instantiateViewController(index: nextIndex, image: backgroundImages[nextIndex], ment: ments[nextIndex])
        return nextVC
    }
    
}

extension HowToPlayViewController: UIPageViewControllerDelegate {
    
    //  스와이프 제스쳐가 끝나면 호출되는 메서드입니다. 여기서 페이지 컨트롤의 인디케이터를 움직여줄꺼에요
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool
    ) {
        //  페이지 이동이 안됐으면 그냥 종료
        guard completed else { return }
        
        //  페이지 이동이 됐기 때문에 페이지 컨트롤의 인디케이터를 갱신해줍시다
        if let vc = pageViewController.viewControllers?.first {
            pageControl.currentPage = vc.view.tag
        }
    }
    
}
