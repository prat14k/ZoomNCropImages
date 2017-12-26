//
//  ViewController.swift
//  ZoomNCropImages
//
//  Created by Prateek Sharma on 23/12/17.
//  Copyright © 2017 Prateek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    lazy var imageView : UIImageView = {
       let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.width))
        imageV.image = UIImage(named: "placeholderImage")
        imageV.isUserInteractionEnabled = true
        
        imageV.contentMode = .scaleAspectFill
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loadImage(_:)))
        tapGesture.numberOfTapsRequired = 1
        imageV.addGestureRecognizer(tapGesture)
        
        return imageV
    }()
    
    
    @objc func loadImage(_ sender : UIGestureRecognizer) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.contentMode = .center
        imageView.frame = CGRect(origin: CGPoint.zero, size: image.size)
        
        scrollView.contentSize = image.size
        let scrollViewFrameSize = scrollView.frame.size
        let scaleWidth = scrollViewFrameSize.width / scrollView.contentSize.width
        let scaleHght = scrollViewFrameSize.height / scrollView.contentSize.height
        let minScale = min(scaleHght, scaleWidth)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1
        scrollView.zoomScale = minScale
        
        centerImageViewInScrollView()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func centerImageViewInScrollView(){
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.addSubview(imageView)
    }
    
    @IBAction func cropImageAction(_ sender: UIButton) {
    }
    
}

