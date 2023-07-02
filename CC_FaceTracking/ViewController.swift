//
//  ViewController.swift
//  CC_FaceTracking
//
//  Created by 최명근 on 2023/07/01.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // TODO: 1) 기본으로 제공되는 Ship 에셋을 Scene에 표시하지 않도록 지운다.
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        // TODO: 2) ARWorldTrackingConfiguration 대신 ARFaceTrackingConfiguration을 사용하여 Face Tracking AR Session을 시작한다.
        let configuration = ARFaceTrackingConfiguration()

        // Run the view's session
        // TODO: 3) 얼굴 인식을 사용하는 앱은 세션을 시작할 때 마다 트래킹을 리셋해주고, 존재하는 anchor를 지워주어야 한다.
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // TODO: 4) 인식된 Face Anchor에 3D 콘텐트가 붙은 SCNNode를 붙여준다.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard anchor is ARFaceAnchor else {
            return nil
        }
        
        guard let resourceUrl = Bundle.main.url(forResource: "robotHead", withExtension: "scn", subdirectory: "Models.scnassets") else {
            return nil
        }
        
        let contentNode = SCNReferenceNode(url: resourceUrl)
        contentNode?.load()
        
        return contentNode
        
        
    }
    
}
