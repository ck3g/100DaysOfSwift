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


  @IBAction func changeFilter(_ sender: UIButton) {
    let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    if let popoverController = ac.popoverPresentationController {
      popoverController.sourceView = sender
      popoverController.sourceRect = sender.bounds
    }

    present(ac, animated: true)
  }

  @IBAction func save(_ sender: Any) {
    guard let image = imageView.image else { return }

    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
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
    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) {
      currentFilter.setValue(intencity.value, forKey: kCIInputIntensityKey)
    }

    if inputKeys.contains(kCIInputRadiusKey) {
      currentFilter.setValue(intencity.value * 200, forKey: kCIInputRadiusKey)
    }

    if inputKeys.contains(kCIInputScaleKey) {
      currentFilter.setValue(intencity.value * 10, forKey: kCIInputScaleKey)
    }

    if inputKeys.contains(kCIInputCenterKey) {
      currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
    }

    guard let outputImage = currentFilter.outputImage else { return }

    if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      let processedImage = UIImage(cgImage: cgImage)
      imageView.image = processedImage
    }
  }

  func setFilter(action: UIAlertAction) {
    guard currentImage != nil else { return }
    guard let actionTitle = action.title else { return }

    currentFilter = CIFilter(name: actionTitle)

    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

    applyProcessing()
  }

  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    var ac: UIAlertController!

    if let error = error {
      ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
    } else {
      ac = UIAlertController(title: "Saved!", message: "Your aletered image has been saved to your photos.", preferredStyle: .alert)
    }

    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
}

