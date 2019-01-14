//
//  MagnetViewController.swift
//  Magnets
//
//  Created by Daniel Yount on 1/14/19.
//  Copyright © 2019 Daniel Yount. All rights reserved.
//

import UIKit

class MagnetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.48, green:0.72, blue:0.79, alpha:1.0)
        
        let frame1 = CGRect(x: 10, y: 30, width: 100, height: 300)
        let frame2 = CGRect(x: 150, y: 100, width: 25, height: 100)
        
        let view1 = UIView(frame: frame1)
        let view2 = UIView(frame: frame2)
        
        view1.backgroundColor = UIColor.red
        view2.backgroundColor = UIColor.green

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        
        view1.addGestureRecognizer(panGesture)
        
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        
        print(view.subviews[0])
        
    }
    
    @objc func didPan(_ sender: UIPanGestureRecognizer) {
        print("Panned!")
        
        let translation = sender.translation(in: self.view)
        
        switch sender.state {
        case .changed:
            print("Moving!")
            let view1 = self.view.subviews[0]
            let view2 = self.view.subviews[1]
            print(CGPoint(x: view1.center.x + translation.x, y: view1.center.y + translation.y))
            self.view.subviews[0].center = CGPoint(x: view1.center.x + translation.x, y: view1.center.y + translation.y)
            
            if view1.overlaps(other: view2, in: self) {
                self.view.subviews[1].center = CGPoint(x: view2.center.x + translation.x, y: view2.center.y + translation.y)
            }
            
            sender.setTranslation(CGPoint.zero, in: self.view)
        default:
            // Default
            print("Cant Do Antyhing!")
            
        }
        
    }

}

extension UIView {
    func overlaps(other view: UIView, in viewController: UIViewController) -> Bool {
        let frame = self.convert(self.bounds, to: viewController.view)
        let otherFrame = view.convert(view.bounds, to: viewController.view)
        return frame.intersects(otherFrame)
    }
}
