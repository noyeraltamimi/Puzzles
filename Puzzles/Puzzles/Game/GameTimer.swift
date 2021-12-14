//
//  GameTimer.swift
//  Puzzles
//
//  Created by noyer altamimi on 10/05/1443 AH.
//

import UIKit

class GameTimer: UIViewController {
    
  @IBOutlet weak var TimerLabel: UILabel!
  @IBOutlet weak var startStopButton: UIButton!
  @IBOutlet weak var resetButton: UIButton!
    
    
  var timer:Timer = Timer()
  var count:Int = 0
  var timerCounting:Bool = false
  override func viewDidLoad() {
    super.viewDidLoad()
    startStopButton.setTitleColor(UIColor.gray, for: .normal)
  }
  @IBAction func resetTapped(_ sender: Any) {
    let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you want to reset the Timer?", preferredStyle: .alert)
    let actionCancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
    let actionOkay = UIAlertAction(title: "YES", style: .default, handler: { action in
      self.count = 0
      self.timer.invalidate()
      self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
      self.startStopButton.setTitle("START", for: .normal)
      self.startStopButton.setTitleColor(UIColor.green, for: .normal)
      }
    )
    alert.addAction(actionOkay)
    alert.addAction(actionCancel)
    self.present(alert, animated: true, completion: nil)
  }
  @IBAction func startStopTapped(_ sender: Any) {
    if(timerCounting) {
      timerCounting = false
      timer.invalidate()
      startStopButton.setTitle("START", for: .normal)
      startStopButton.setTitleColor(UIColor.gray, for: .normal)
    } else {
      timerCounting = true
      startStopButton.setTitle("STOP", for: .normal)
      startStopButton.setTitleColor(UIColor.red, for: .normal)
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
  }
  @objc func timerCounter() -> Void {
    count = count + 1
    let time = secodsToHoursMinutesSeconds(seconds: count)
    let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
    TimerLabel.text = timeString
  }
  func secodsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
    return ((seconds / 3600) , ((seconds % 3600) / 60 ) , ((seconds % 3600) % 60))
  }
  func makeTimeString(hours: Int , minutes: Int , seconds : Int) -> String {
    var timeString = ""
    timeString += String(format: "0%2d", hours)
    timeString += " : "
    timeString += String(format: "0%2d", minutes)
    timeString += " : "
    timeString += String(format: "0%2d", seconds)
    return timeString
  }
}
