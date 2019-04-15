//
//  ViewController.swift
//  lab4-carGenerator
//
//  Created by 陳嬿晴 on 2019/4/14.
//  Copyright © 2019 陳嬿晴. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var plateTextField: UITextField!
    @IBOutlet weak var datePickerValue: UIDatePicker!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var blendsSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var blendsLabel: UILabel!
    
    var looper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let url = URL(string: "https://bit.ly/2GcXcL8") {
            let player = AVQueuePlayer()
            let item = AVPlayerItem(url: url)
            looper = AVPlayerLooper(player: player, templateItem: item)
            player.play()
        }
        
        var images = [UIImage]()
        for number in 0...16 {
            let image = UIImage(named: String(format: "0-%d", number))!
            images.append(image)
        }
        let animatedImage = UIImage.animatedImage(with: images, duration: 1.5)
        gifImageView.image = animatedImage
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        imageView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        
        redLabel.text = String(format:  "%.2f", redSlider.value)
        greenLabel.text = String(format:  "%.2f", greenSlider.value)
        blueLabel.text = String(format:  "%.2f", blueSlider.value)
        alphaLabel.text = String(format:  "%.2f", alphaSlider.value)
    }
    
    @IBAction func blendsSliderChanged(_ sender: UISlider) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = background.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.magenta.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, NSNumber(value: blendsSlider.value)]
        background.layer.addSublayer(gradientLayer)
        
        blendsLabel.text = String(format: "%.2f", blendsSlider.value)
    }
    
    @IBAction func blendsSwitch(_ sender: UISwitch) {
        if sender.isOn
        {
            redSlider.isEnabled = true
            greenSlider.isEnabled = true
            blueSlider.isEnabled = true
            alphaSlider.isEnabled = true
            blendsSlider.isEnabled = true
        }
        else
        {
            redSlider.isEnabled = false
            greenSlider.isEnabled = false
            blueSlider.isEnabled = false
            alphaSlider.isEnabled = false
            blendsSlider.isEnabled = false
        }
    }
    
    @IBAction func randomColorBtnPressed(_ sender: Any) {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        let alpha = Double.random(in: 0...1)
        
        imageView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        redLabel.text = String(format:  "%.2f", red)
        greenLabel.text = String(format:  "%.2f", green)
        blueLabel.text = String(format:  "%.2f", blue)
        alphaLabel.text = String(format:  "%.2f", alpha)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { //判斷使用者選擇是哪一個Segmented 0是付費App、1是免費App
            imageView.image = UIImage(named: "藍寶堅尼烤漆去背") //顯示付費圖片
        }else {
            imageView.image = UIImage(named: "法拉利烤漆去背圖2") //顯示免費圖片
        }
    }

}

