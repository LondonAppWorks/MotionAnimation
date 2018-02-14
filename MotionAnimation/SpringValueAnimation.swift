//
//  SpringValueAnimation.swift
//  DynamicView
//
//  Created by YiLun Zhao on 2016-01-17.
//  Copyright © 2016 lkzhao. All rights reserved.
//

import UIKit


open class SpringValueAnimation:ValueAnimation {
  @objc open var threshold:CGFloat = 0.001
  @objc open var stiffness:CGFloat = 150
  @objc open var damping:CGFloat = 10

  //from https://github.com/chenglou/react-motion
  open override func update(_ dt:CGFloat) -> Bool{
    var running = false
    for i in 0..<values.count{
      // Force
      let Fspring = -stiffness * (values[i] - target[i]);

      // Damping
      let Fdamper = -damping * velocity[i];

      let a = Fspring + Fdamper;

      let newV = velocity[i] + a * dt;
      let newX = values[i] + newV * dt;

      if abs(velocity[i]) < threshold && abs(target[i] - newX) < threshold {
        values[i] = target[i]
        velocity[i] = 0
      }else{
        values[i] = newX
        velocity[i] = newV
        running = true
      }
    }
    return running
  }
}
