//
//  ViewController.swift
//  pedometer
//
//  Created by Jake Benton on 5/1/18.
//

import UIKit
import CoreMotion



class ViewController: UIViewController {

    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    @IBOutlet weak var activityTypeLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        }

        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }
    }

    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: .main) { [weak self] activity in
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self?.activityTypeLabel.text = "Walking"
                } else if activity.stationary {
                    self?.activityTypeLabel.text = "Stationary"
                } else if activity.running {
                    self?.activityTypeLabel.text = "Running"
                } else if activity.automotive {
                    self?.activityTypeLabel.text = "Automotive"
                }
            }
        }
    }

    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) { [weak self] data, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self?.stepsLabel.text = data.numberOfSteps.stringValue
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

