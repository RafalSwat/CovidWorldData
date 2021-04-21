//
//  ViewController.swift
//  CovidWorldData
//
//  Created by Rafał Swat on 12/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let networkHandler    = NetworkHandler()
    let customPurpleColor = UIColor(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1.0).cgColor
    var showAlert         = false
    var alertText         = ""
    var result            : ResultsModel?
    
    @IBOutlet weak var verticalStack : UIStackView!
    @IBOutlet weak var titleLabel    : UILabel!
    @IBOutlet weak var textField     : UITextField!
    @IBOutlet weak var searchButton  : UIButton!
    @IBOutlet weak var alertLabel    : UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setButtonAppearance()
        setVStackAppearance()
    }
    @IBAction func searchButtonTapped(_ sender: Any) {

            self.loadData(completion: { finishDownloadingData in
                if finishDownloadingData {
                    self.performSegue(withIdentifier: "resultSegue" , sender: self)
                } else {
                    self.setupAlertLabelAppearance()
                }
            })
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let resultViewController = segue.destination as! ResultsViewController
            resultViewController.results = self.result
        }
    }
    
    
    func setVStackAppearance() {
        verticalStack.setCustomSpacing(70, after: titleLabel)
        verticalStack.setCustomSpacing(20, after: textField)
    }

    func setButtonAppearance() {
        searchButton.layer.shadowColor   = customPurpleColor 
        searchButton.layer.shadowOffset  = CGSize(width: 0, height: 0)
        searchButton.layer.shadowOpacity = 1.0
        searchButton.layer.shadowRadius  = 10
        searchButton.layer.masksToBounds = true
        searchButton.titleEdgeInsets     = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        searchButton.layer.cornerRadius  = 20
        searchButton.layer.borderWidth   = 1
        searchButton.layer.borderColor   = UIColor.black.cgColor
    }
    
    func setupAlertLabelAppearance() {
        alertLabel.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        alertLabel.layer.cornerRadius = 20
        alertLabel.text = alertText
    }

    func loadData(completion: @escaping (Bool)->()) {
        if textField.text != "" {
            if let country = textField.text {
                networkHandler.fetchCovData(from: country, completion: { result, errorOccur, errorDescription in
                    if !errorOccur {
                        DispatchQueue.main.async {
                            self.result = result
                            completion(true)
                        }
                    } else {
                        self.showAlert = true
                        self.alertText = errorDescription ?? "error: 404 not found"
                        completion(false)
                    }
                })
            }
        } else {
            self.showAlert = true
            self.alertText = "Please, enter the country name!"
            completion(false)
        }
    }
}


