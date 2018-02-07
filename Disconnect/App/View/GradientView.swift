//
//  GradientView.swift
//  Disconnect
//
//  Created by Maarten Zonneveld on 07/02/2018.
//  Copyright © 2018 Maarten Zonneveld. All rights reserved.
//

import UIKit.UIView

internal class GradientView: UIView {

    var startColor = UIColor.white {
        didSet {
            self.setColors()
        }
    }

    var endColor = UIColor.white {
        didSet {
            self.setColors()
        }
    }

    private weak var gradientLayer: CAGradientLayer?

    private func setColors() {
        self.gradientLayer?.colors = [self.startColor.cgColor, self.endColor.cgColor]
        self.gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0.4)
        self.gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.setNeedsDisplay()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        let gradientLayer = CAGradientLayer()
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer

        self.setColors()
        self.setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer?.frame = self.bounds
    }
}
