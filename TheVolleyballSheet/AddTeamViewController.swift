//
//  AddTeamViewController.swift
//  TheVolleyballSheet
//
//  Created by Todd McCready on 4/9/15.
//  Copyright (c) 2015 Todd McCready. All rights reserved.
//

import UIKit
import CoreData

protocol AddTeamViewControllerDelegate {
    func addTeam(message: String)
    func addTeamCanceled(message: String)
}

class AddTeamViewController: UIViewController {

    var delegate:AddTeamViewControllerDelegate?
    
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var leagueNameTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var inSeasonSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTeamCanceled("Team was not added")
    }
    
    @IBAction func saveNewTeamButtonPressed(sender: UIButton) {
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("Teams", inManagedObjectContext: managedObjectContext!)
        let team = Teams(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)

        team.teamName = teamNameTextField.text
        team.leagueName = leagueNameTextField.text
        team.season = seasonTextField.text
        team.isCurrentSeason = inSeasonSwitch.on
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "Teams")
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        for res in results {
            println(res)
        }

        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTeam("Team Added")
    }

}
