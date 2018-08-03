//
//  ViewController.swift
//  ImageScroller
//
//  Created by Brian on 2/9/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var imageView: UIImageView!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scrollView.contentInsetAdjustmentBehavior = .never
		
		/*
		// Set scrollview's contentSize fit to image size
		if let contentSize = imageView?.image?.size {
		scrollView.contentSize = contentSize
		}
		*/
		
		imageView.frame.size = (imageView.image?.size)!
		scrollView.delegate = self
		setZoomParametersForSize(scrollView.bounds.size)
		
	}
	override func viewWillLayoutSubviews() {
		setZoomParametersForSize(scrollView.bounds.size)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setZoomParametersForSize(_ scrollViewSize: CGSize){
		let imageSize = imageView.bounds.size
		let widthScale = scrollViewSize.width / imageSize.width
		let heightScale = scrollViewSize.height / imageSize.height
		
		let minScale = min(widthScale, heightScale)
		
		scrollView.minimumZoomScale = minScale
		scrollView.maximumZoomScale = 2.0
		scrollView.zoomScale = minScale
	}
}

extension ViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
