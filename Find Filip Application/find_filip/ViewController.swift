//
//  ViewController.swift
//  find_filip
//
//  Created by Jiangqi Su on 11/1/21.
//

import UIKit
import RealityKit


var filipAnchor: TrainExperience.Scene?

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filipAnchor = try! TrainExperience.loadScene()
        arView.scene.anchors.append(filipAnchor!)
    }
    
    @IBAction func PutFilip(_ sender: Any) {
        let cameraLoc = arView.cameraTransform
        filipAnchor?.filip?.move(to: cameraLoc, relativeTo: nil)
    }
    
    @IBAction func MeetFilip(_ sender: UIButton){
        performSegue(withIdentifier: "gotomeet", sender: self)
    }
    
    @IBAction func RandomLocation(_ sender: Any) {
        filipAnchor?.filip?.move(to: getRandomLoc(), relativeTo: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let filipAncher = try! FilipExperience.loadScene()
        let filipAncher = try! TrainExperience.loadScene()
        arView.scene.anchors.append(filipAncher)
    }
    
    @IBOutlet var arView: ARView!
    
    func getRandomLoc() -> Transform{
        var cameraLoc = arView.cameraTransform
        cameraLoc.translation.x += Float.random(in: 1..<10)
        cameraLoc.translation.z += Float.random(in: 1..<5)
        cameraLoc.translation.y = 1
        return cameraLoc
    }
    @IBOutlet weak var scalescene: UILabel!
    @IBOutlet weak var scaleSize: UILabel!
    @IBAction func sizescene(_ sender: UISlider) {
        var string = "Scale scene " + sender.value.description
        scalescene.text = string
        filipAnchor?.parent?.setScale(SIMD3<Float>(sender.value*2, sender.value*2, sender.value*2), relativeTo: filipAnchor?.pill)
    }
    @IBAction func scale(_ sender: UISlider) {
        var string = "Scale Filip " + sender.value.description
        scaleSize.text = string
        filipAnchor?.filip?.setScale(SIMD3<Float>(sender.value*0.3, sender.value*0.3, sender.value*0.3), relativeTo: filipAnchor?.pill)
    }
}
