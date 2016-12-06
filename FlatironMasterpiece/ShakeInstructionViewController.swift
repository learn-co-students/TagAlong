//
//  ShakeInstructionViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/22/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
class ShakeInstructionViewController: UIViewController {
 
    var shakeView: ShakeView!
    var shakeNosie: AVAudioPlayer?
    var vview: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        vview = ShakeView()
        view.backgroundColor = UIColor.blue
        if view == vview {
            vibrate()
            playSound()
        }
        playSound()

   
    }

    
    override func loadView() {
        super.loadView()
        shakeView = ShakeView()
        self.view = shakeView
    }
    
    
    func setupAudioPlayerWithFile(file: String, type: String) -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: file as String, ofType: type as String)
        let url = URL(fileURLWithPath: path!)
        
        var audioPlayer: AVAudioPlayer?
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Nothing to play")
        }
        return audioPlayer
    }
    
    func loadPlayer() {
        if let shakeNosie = self.setupAudioPlayerWithFile(file: "SprayShake", type: "mp3") {
            self.shakeNosie = shakeNosie
            
        }
        self.shakeNosie?.volume = 1.0
        self.shakeNosie?.play()
    }
    
    func playSound() {
       loadPlayer()
    }
    func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEventSubtype.motionShake) {
            print("shaken")
            
            //TODO: 1) segue to deck view 2) have the phone vibrate/pulsate 3) shaking sounds
            let deckView = CardViewController()
            self.navigationController?.pushViewController(deckView, animated: false)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
