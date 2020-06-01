//
//  ViewController.swift
//  Instafilter
//
//  Created by Vitali Tatarintev on 01.06.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var intencity: UISlider!

  var currentImage: UIImage!
  var context: CIContext!
  var currentFilter: CIFilter!

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "YACIFP"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))

    context = CIContext()
    currentFilter = CIFilter(name: "CISepiaTone")
  }


  @IBAction func changeFilter(_ sender: Any) {
  }

  @IBAction func save(_ sender: Any) {
  }

  @IBAction func intencityChanged(_ sender: Any) {
    applyProcessing()
  }

  @objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    dismiss(animated: true)
    currentImage = image

    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }

  func applyProcessing() {
    guard let outputImage = currentFilter.outputImage else { return }

    currentFilter.setValue(intencity.value, forKey: kCIInputIntensityKey)

    if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      let processedImage = UIImage(cgImage: cgImage)
      imageView.image = processedImage
    }
  }
}

