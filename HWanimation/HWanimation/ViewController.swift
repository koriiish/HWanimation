//
//  ViewController.swift
//  HWanimation
//
//  Created by Карина Дьячина on 20.01.24.
//

import UIKit

class ViewController: UIViewController {
    
    let circleRadius: CGFloat = 50
    var circleView: UIView!
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleConfigure()
        
    }
    
    func circleConfigure() {
        let circleOrigin = CGPoint(x: view.bounds.midX - circleRadius, y: view.bounds.midY - circleRadius)
        circleView = UIView(frame: CGRect(origin: circleOrigin, size: CGSize(width: circleRadius * 2, height: circleRadius * 2)))
        circleView.backgroundColor = UIColor.systemPink
        circleView.layer.cornerRadius = circleRadius
        view.addSubview(circleView)
        
        let upButton = createButton(title: "⬆️", frame: CGRect(x: 100, y: 750, width: 50, height: 50))
        upButton.backgroundColor = UIColor.systemGray4
        let downButton = createButton(title: "⬇️", frame: CGRect(x: 150, y: 750, width: 50, height: 50))
        downButton.backgroundColor = UIColor.systemGray4
        let leftButton = createButton(title: "⬅️", frame: CGRect(x: 200, y: 750, width: 50, height: 50))
        leftButton.backgroundColor = UIColor.systemGray4
        let rightButton = createButton(title: "➡️", frame: CGRect(x:250, y: 750, width: 50, height: 50))
        rightButton.backgroundColor = UIColor.systemGray4
        
        buttons = [upButton, downButton, leftButton, rightButton]
        
        for button in buttons {
            view.addSubview(button)
        }
    }
    
    func createButton(title: String, frame: CGRect) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.frame = frame
        button.addTarget(self, action: #selector(moveCircle(_:)), for: .touchUpInside)
        return button
        
    }
    
    @objc func moveCircle(_ sender: UIButton) {
        var newFrame = circleView.frame
        
        switch sender.titleLabel?.text {
        case "⬆️":
            newFrame.origin.y -= 50
            UIView.animate(withDuration: 1.5,
                           delay: 0.0,
                           usingSpringWithDamping: 0.2, //значение на сколько пружинить
                           initialSpringVelocity: 0.0,
                           options: [],
                           animations: {
                self.circleView.center = CGPoint(x: self.view.center.x, y: 300)
            }, completion: nil)
        case "⬇️":
            newFrame.origin.y += 50
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .autoreverse, animations: {
                self.circleView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                   }, completion: nil)
        case "⬅️":
            newFrame.origin.x -= 50
            UIView.animate(withDuration: 2.0) {
                self.circleView.center = CGPoint(x: self.view.center.x, y: 400)
                    }
        case "➡️":
            newFrame.origin.x += 50
            UIView.animate(withDuration: 2.0) {
                self.circleView.transform = CGAffineTransform(scaleX: 0.5, y: 1.5)
                } completion: { _ in
                    self.circleView.transform = .identity
            }
        default:
            break
        }
        
        if isFrameValid(newFrame) {
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame = newFrame
            }
        }
    }
    func isFrameValid(_ frame: CGRect) -> Bool {
        if frame.minX < 0 || frame.minY < 0 || frame.maxX > view.bounds.width || frame.maxY > view.bounds.height {
            return false
        }
        
        for button in buttons {
            if frame.intersects(button.frame) {
                return false
            }
        }
        return true
    }
}

