//
//  ViewController.swift
//  ARTest
//
//  Created by Atsuo Yonehara on 2017/08/08.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate, AVAudioPlayerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/aichan.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // 再生する音源のURLを生成
        let soundFilePath : String = Bundle.main.path(forResource: "00", ofType: "mp3")!
        let fileURL : URL = URL(fileURLWithPath: soundFilePath)
        
        do{
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
        }
        catch{
        }
        
        saisei()
    }
    
    // 声の再生メソッド
    func saisei() {
        // playingプロパティがtrueであれば音源再生中
        if audioPlayer.isPlaying == true {
            
            // audioPlayerを一時停止
            audioPlayer.pause()
        } else {
            // audioPlayerの再生
            audioPlayer.play()
        }
    }
    
    // 音楽再生が成功した時に呼ばれるメソッド
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Music Finish")
    }
    
    // デコード中にエラーが起きた時に呼ばれるメソッド
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Error")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
