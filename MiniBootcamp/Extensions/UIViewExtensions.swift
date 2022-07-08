//
//  UIViewExtensions.swift
//  MiniBootcamp
//
//  Created by Abner Castro on 28/04/22.
//

import Foundation
import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, multiplier: CGFloat = 0.0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
  
  func showBlurLoader() {
    let blurLoader = BlurLoader(frame: self.frame)
    self.addSubview(blurLoader)
  }

  func removeBluerLoader() {
    if let blurLoader = self.subviews.first(where: { $0 is BlurLoader }) {
      blurLoader.removeFromSuperview()
    }
  }
}

class BlurLoader: UIView {

  var blurEffectView: UIVisualEffectView?

  override init(frame: CGRect) {
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = frame
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.blurEffectView = blurEffectView
    super.init(frame: frame)
    backgroundColor = .systemCyan
    addSubview(blurEffectView)
    addLoader()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func addLoader() {
    guard let blurEffectView = blurEffectView else { return }
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    blurEffectView.contentView.addSubview(activityIndicator)
    activityIndicator.center = blurEffectView.contentView.center
    activityIndicator.startAnimating()
  }
}

