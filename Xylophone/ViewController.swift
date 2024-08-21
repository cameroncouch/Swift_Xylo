import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    @IBOutlet var xyloKeys: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in xyloKeys {
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            button.addGestureRecognizer(panGesture)
            button.isExclusiveTouch = false
        }
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        playSound(letter:sender.titleLabel?.text ?? "B")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            sender.alpha = 1
        }
    }
    
    /* Attempt to handle moving finger over each key and playing them, instead of needing individual taps -- does not work currently */
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        for key in xyloKeys {
            if key.frame.contains(location) {
                print(location)
                print(key.titleLabel?.text ?? "C")
                playSound(letter:key.titleLabel?.text ?? "B")
                break;
            }
        }
    }
    
    func playSound(letter:String) {
        let url = Bundle.main.url(forResource: letter, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
