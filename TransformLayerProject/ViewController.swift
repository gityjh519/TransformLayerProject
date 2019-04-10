//
//  ViewController.swift
//  TransformLayerProject
//
//  Created by yaojinhai on 2019/4/9.
//  Copyright © 2019年 yaojinhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var containLayer: CATransformLayer!
    let sRect = CGRect.init(x: (ScreenData.width - 100)/2, y: 0, width: 100, height: 100);


    var degree: CGFloat = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        containLayer = CATransformLayer();
        containLayer.backgroundColor = UIColor.green.cgColor;

        containLayer.frame = sRect;
        view.layer.addSublayer(containLayer);
        containLayer.position = self.view.center;
        
        createSubLayer();
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        runAnimation();
    }
    
    func createSubLayer() -> Void {
        var tranfrom = CATransform3DMakeTranslation(0, 0, sRect.width/2);
        addSubLayerTo(trans: tranfrom,index: 1);
        
        tranfrom = CATransform3DMakeTranslation(0, 0, -sRect.width/2);
        addSubLayerTo(trans: tranfrom, index: 2);
        
        tranfrom = CATransform3DMakeTranslation(0, sRect.height/2,0);
        tranfrom = CATransform3DRotate(tranfrom, .pi/2, 1, 0, 0);
        addSubLayerTo(trans: tranfrom, index: 3);
        
        tranfrom = CATransform3DMakeTranslation(0, -sRect.height/2, 0);
        tranfrom = CATransform3DRotate(tranfrom, .pi/2, 1, 0, 0);
        addSubLayerTo(trans: tranfrom, index: 4);
        
        tranfrom = CATransform3DMakeTranslation(sRect.width/2, 0, 0);
        tranfrom = CATransform3DRotate(tranfrom, .pi/2, 0, 1, 0);
        
        addSubLayerTo(trans: tranfrom, index: 5);
        tranfrom = CATransform3DMakeTranslation(-sRect.width/2, 0, 0);
        tranfrom = CATransform3DRotate(tranfrom, .pi/2, 0, 1, 0);
        
        addSubLayerTo(trans: tranfrom, index: 6);
        
    }
    func addSubLayerTo(trans: CATransform3D,index: Int) -> Void {
        let layer = CATextLayer();
        layer.frame = .init(x: 0, y: 0, width: sRect.width, height: sRect.height);
        
        containLayer?.addSublayer(layer);
        layer.transform = trans;
        layer.backgroundColor = UIColor.random.cgColor;
        layer.string = "\(index)";
        layer.alignmentMode = .center;
        layer.contentsGravity = .center;
        layer.fontSize = 40;
        layer.foregroundColor = UIColor.random.cgColor;
    }
    
    func runAnimation() -> Void {
        
        var frame = CATransform3DIdentity;
        frame.m34 = -1.0/500.0;
        frame = CATransform3DRotate(frame, degree, 0, 1, 0);
        
        degree += .pi * 1.1
        var toend = CATransform3DIdentity;
        toend.m34 = -1.0/500;
        toend = CATransform3DRotate(toend, degree, 1, 1, 1);
        
        let transform3d = CABasicAnimation(keyPath: "transform");
        transform3d.duration = 5;
        transform3d.fromValue = frame;
        transform3d.toValue = toend;
        transform3d.repeatCount = 100;
        transform3d.fillMode = .forwards;
        transform3d.isAdditive = true;
        transform3d.autoreverses = true;
        
        containLayer?.add(transform3d, forKey: "transform3d");
    }


}

