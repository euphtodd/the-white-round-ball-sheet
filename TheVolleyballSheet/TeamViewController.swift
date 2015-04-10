//
//  TeamViewController.swift
//  TheVolleyballSheet
//
//  Created by Todd McCready on 4/9/15.
//  Copyright (c) 2015 Todd McCready. All rights reserved.
//

import UIKit
import CoreData

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, AddTeamViewControllerDelegate, TeamDetailViewControllerDelegate {

    @IBOutlet weak var teamTableView: UITableView!

    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTeamDetail" {
            let detailVC: TeamDetailViewController = segue.destinationViewController as TeamDetailViewController
            let indexPath = self.teamTableView.indexPathForSelectedRow()
            let thisTeam = fetchedResultsController.objectAtIndexPath(indexPath!) as Teams
            detailVC.detailTeam = thisTeam
            detailVC.delegate = self
        } else if segue.identifier == "showTeamAdd" {
            let addTeamVC:AddTeamViewController = segue.destinationViewController as AddTeamViewController
            addTeamVC.delegate = self
        }
    }

    @IBAction func addTeamBarButtonItemPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTeamAdd", sender: self)
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }

    // formatting headers
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if fetchedResultsController.sections?.count == 1 {
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            let testTeam:Teams = fetchedObjects[0] as Teams
            if testTeam.isCurrentSeason == true {
                return "Current Season"
            } else {
                return "Past Seasons"
            }
        }
        else {
            if section == 0 {
                return "Current Season"
            } else {
                return "Past Seasons"
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisTeam = fetchedResultsController.objectAtIndexPath(indexPath) as Teams
        
        var cell: TeamTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as TeamTableViewCell
        
        cell.teamNameLabel.text = thisTeam.teamName
        cell.leagueLabel.text = thisTeam.leagueName
        cell.seasonLabel.text = thisTeam.season
        cell.winsLabel.text = "0"
        cell.lossesLabel.text = "0"
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
     }

    // NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        teamTableView.reloadData()
    }
    
    //Helper
    
    func teamFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Teams")
        let sortDescriptor = NSSortDescriptor(key: "teamName", ascending: true)
        let currentSeasonDescriptor = NSSortDescriptor(key: "isCurrentSeason", ascending: false)
        fetchRequest.sortDescriptors = [currentSeasonDescriptor, sortDescriptor]

        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: teamFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "isCurrentSeason", cacheName: nil)
        return fetchedResultsController
    }
    
    //AddTeamViewControllerDelegate
    func addTeam(message: String) {
        showAlert(message: message)
    }
    
    func addTeamCanceled(message: String) {
        showAlert(message: message)
    }
    
    func showAlert(message: String = "Congratulations") {
        var alert = UIAlertController(title: "Change Made", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
