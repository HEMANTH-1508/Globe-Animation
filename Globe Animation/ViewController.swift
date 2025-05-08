//
//  ViewController.swift
//  Globe Animation
//
//  Created by HEMANTH K on 06/05/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Globe: UIImageView!
    @IBOutlet weak var ScrollBar: UIView!
    @IBOutlet weak var StarBTN: UIImageView!
    
    private var initialCenterY: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScrollBar.layer.cornerRadius = ScrollBar.frame.width / 2
        ScrollBar.clipsToBounds = true

        StarBTN.layer.cornerRadius = StarBTN.frame.size.width / 1.75
        StarBTN.clipsToBounds = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        StarBTN.isUserInteractionEnabled = true
        StarBTN.addGestureRecognizer(panGesture)
    }

    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: ScrollBar)
            guard let starView = gesture.view else { return }

            switch gesture.state {
            case .began:
                initialCenterY = starView.center.y
            case .changed:
                let newY = min(max(initialCenterY + translation.y, 0), ScrollBar.bounds.height)
                starView.center.y = newY

                let percentage = newY / ScrollBar.bounds.height
                rotateGlobe(with: percentage)
            default:
                break
            }
        }

        private func rotateGlobe(with percentage: CGFloat) {
            let rotationAngle = CGFloat.pi * 2 * percentage
            Globe.transform = CGAffineTransform(rotationAngle: rotationAngle)
        }

}

