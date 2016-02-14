//
//  MainTableViewController.swift
//  My_beginner_Spotify
//
//  Created by Gandhi Mena Salas on 09/02/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit
import AVFoundation


class MainTableViewController: UITableViewController {
    
    
    
//*****************Variables
    var listaCanciones : Array<Array<String>> = Array<Array<String>>()
    var cancionSeleccionada: Int = 0
    var portadaIndice:NSData!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listaCanciones.append(["Banjo Short",           "AudioNautix",  "image1", "sound1"])
        listaCanciones.append(["Baroque Coffee House",  "Doug Maxwell", "image2", "sound2"])
        listaCanciones.append(["Leslie's Struct",       "Jhon Deley",   "image3", "sound3"])
        listaCanciones.append(["Far Away",              "MK2",          "image4", "sound4"])
        listaCanciones.append(["Cartoon Bank",          "Doug Maxwell", "image5", "sound5"])
        listaCanciones.append(["Timed Out",             "Jingle Punk",  "image6", "sound6"])
        
        
        
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return listaCanciones.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        
        cell.textLabel?.text = self.listaCanciones[indexPath.row][0]
        
        let imgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaCanciones[indexPath.row][2], ofType: "jpg")!)
        let imgData = NSData(contentsOfURL: imgUrl)
        
        cell.imageView?.image = UIImage(data: imgData!)
        
        


        return cell
    }
    


    
    func tableView(tableView: UITableView, didSelecRowAtIndexPath indexPath: NSIndexPath){
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        cancionSeleccionada = indexPath.row
        
        self.performSegueWithIdentifier("details", sender: cancionSeleccionada)
        
    
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DetailsView: DetailsViewController = segue.destinationViewController as! DetailsViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        
        DetailsView.tituloCancion = self.listaCanciones[indexPath!.row][0] //titulos
        DetailsView.autorCancion = self.listaCanciones[indexPath!.row][1] //autores
        DetailsView.nombreportada = self.listaCanciones[indexPath!.row][2] //portadas
        DetailsView.audioCancion = self.listaCanciones[indexPath!.row][3] //audios
                


    }
    

}
