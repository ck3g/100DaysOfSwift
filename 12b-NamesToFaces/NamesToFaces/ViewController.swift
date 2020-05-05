//
//  ViewController.swift
//  NamesToFaces
//
//  Created by Vitali Tatarintev on 28.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var people = [Person]()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return people.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
      // we failed to get a PersonCell – bail out!
      fatalError("Unable to dequeue PersonCell.")
    }

    let person = people[indexPath.item]

    cell.name.text = person.name

    let path = getDocumentsDirectory().appendingPathComponent(person.image)
    cell.imageView.image = UIImage(contentsOfFile: path.path)

    cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.imageView.layer.borderWidth = 2
    cell.imageView.layer.cornerRadius = 3
    cell.layer.cornerRadius = 7

    return cell
  }

  @objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self

    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      picker.sourceType = .camera
    }

    present(picker, animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
      try? jpegData.write(to: imagePath)
    }

    let person = Person(name: "Unknown", image: imageName)
    people.append(person)
    save()
    collectionView.reloadData()

    dismiss(animated: true)
  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]

    let ac = UIAlertController(title: "Rename or delete?", message: "Would you like to rename or delete the person?", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Rename...", style: .default) { [weak self] _ in
      guard let self = self else { return }

      self.renamePersonAlert(person)
    })

    ac.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
      self?.people.removeAll(where: { $0 == person })
      self?.save()
      self?.collectionView.reloadData()
    })

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    present(ac, animated: true)
  }

  func renamePersonAlert(_ person: Person) {
    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
    ac.addTextField()

    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
      guard let newName = ac?.textFields?[0].text else { return }

      person.name = newName
      self?.save()
      self?.collectionView.reloadData()
    })

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    present(ac, animated: true)
  }

  func save() {
    let jsonEncoder = JSONEncoder()

    if let savedData = try? jsonEncoder.encode(people) {
      let defaults = UserDefaults.standard
      defaults.set(savedData, forKey: "people")
    } else {
      print("Failed to save people.")
    }
  }
}
