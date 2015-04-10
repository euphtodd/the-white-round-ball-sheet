//
//  TeamDetailViewController.swift
//  TheVolleyballSheet
//
//  Created by Todd McCready on 4/9/15.
//  Copyright (c) 2015 Todd McCready. All rights reserved.
//

import UIKit
import CoreData

protocol TeamDetailViewControllerDelegate {
    
}

class TeamDetailViewController: UIViewController {
    
    var detailTeam: Teams!
    var delegate: TeamDetailViewControllerDelegate?

    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var leagueNameTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var inSeasonSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.teamNameTextField.text = detailTeam.teamName
        self.leagueNameTextField.text = detailTeam.leagueName
        self.seasonTextField.text = detailTeam.season
        if detailTeam.isCurrentSeason == true {
            self.inSeasonSwitch.on = true
        } else {
            self.inSeasonSwitch.on = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarButtonItemPressed(sender: UIBarButtonItem) {
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        detailTeam.teamName = teamNameTextField.text
        detailTeam.leagueName = leagueNameTextField.text
        detailTeam.season = seasonTextField.text
        detailTeam.isCurrentSeason = self.inSeasonSwitch.on
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
