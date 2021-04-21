//
//  ResultsViewController.swift
//  CovidWorldData
//
//  Created by Rafał Swat on 14/04/2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var results: ResultsModel?
    
    @IBOutlet weak var baseInfoVStack: UIStackView!
    @IBOutlet weak var currentDataVStack: UIStackView!
    @IBOutlet weak var seriousOrCriticalHStack: UIStackView!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var allCasesLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var currentlyInfectedLabel: UILabel!
    @IBOutlet weak var midConditionLabel: UILabel!
    @IBOutlet weak var seriousOrCriticalLabel: UILabel!
    @IBOutlet weak var newCasesLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupCurrentDataVStackAppearance()
    }
    
    func setupBaseInfoVStackAppearance() {}
    
    func setupCurrentDataVStackAppearance() {
        currentDataVStack.setCustomSpacing(40, after: seriousOrCriticalHStack)
    }
    
    func setupLabels() {
        countryLabel.text = results?.country
        lastUpdateLabel.text = results?.lastUpdated
        allCasesLabel.text = results?.casesCount
        deathsLabel.text = results?.deathCount
        recoveredLabel.text = results?.recoveredCount
        currentlyInfectedLabel.text = results?.infectedCount
        midConditionLabel.text = results?.midConditionCount
        seriousOrCriticalLabel.text = results?.seriousOrCriticalCount
        newCasesLabel.text = results?.newCasesCount
    }

}
