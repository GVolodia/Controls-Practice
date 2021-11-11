//
//  ViewController.swift
//  Controls Practice
//
//  Created by noone on 10.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    
    var number = 128 {
        didSet {
            number = (number + 256) % 256
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateSwitches()
        updateUI()
    }
    
    /// Rotates switches to be vertically oriented
    func rotateSwitches() {
        for `switch` in switches {
            `switch`.layer.transform = CATransform3DMakeRotation(-.pi / 2, 0, 0, 1)
        }
    }
    
    /// Updates number from the switches set
    func updateNumberFromSwitches() {
        var number = 0
        for `switch` in switches {
            number += `switch`.isOn ? `switch`.tag : 0
        }
        self.number = number
    }
    
    /// Udpates switches from the number
    func updateSwitches() {
//        var number = self.number
        for `switch` in switches.reversed() {
            `switch`.isOn = Int(number) & `switch`.tag != 0
        }
    }
    
    /// Updates all outlets number
    func updateUI() {
        
        button.setTitle("\(number)", for: [])
        
        updateSwitches()
        
        slider.value = Float(number)
        
        textField.text = "\(number)"
    }
    
    @IBAction func buttonPressed() {
        number = (number + 1) % 256
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        updateNumberFromSwitches()
    }
    
    @IBAction func sliderMoved() {
        number = Int(slider.value)
    }
    
    @IBAction func textFieldEdited() {
        number = Int(textField.text ?? "") ?? 128
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if location.x < view.bounds.midX {
            number -= 1
        } else {
            number += 1
        }
    }
}

