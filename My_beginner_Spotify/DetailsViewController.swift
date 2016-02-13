//
//  DetailsViewController.swift
//  My_beginner_Spotify
//
//  Created by Gandhi Mena Salas on 09/02/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit
import AVFoundation

class DetailsViewController: UIViewController,AVAudioPlayerDelegate {
    
    
    
    
//************Variables
    var Main: MainTableViewController = MainTableViewController()
    var tituloCancion:String?
    var autorCancion: String?
    var nombreportada: String?
    var audioCancion: String?
    var shuffleCancion: String?
    

    var reproductor = AVAudioPlayer()
    var shuffle = AVAudioPlayer()

//*************Outlets
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!
    

    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        titulo.text = tituloCancion
        autor.text = autorCancion
        
        // url de portada, audios y audios shuffle seleccionados
        let imgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(nombreportada, ofType: "jpg")!)
        let imgData = NSData(contentsOfURL: imgUrl)
        let shuffleUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(shuffleCancion, ofType: "mp3")!)
        
        let cancionDir = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(audioCancion, ofType: "mp3")!)
        
        
        do{
            
            try shuffle = AVAudioPlayer(contentsOfURL: shuffleUrl)
            
            try reproductor = AVAudioPlayer(contentsOfURL: cancionDir)
            reproductor.play()
            
            portada.image = UIImage(data: imgData!)
            
            
        }catch{
            
        }
        

    }

    @IBAction func reproducirMusica(sender: UIButton) {
        
        let botones:String = (sender.titleLabel?.text)!
        
        switch botones {
            
            case "play":
                
                if !reproductor.playing{
                    
                    reproductor.play()
                    
                }
            
            
            case "pause":
                
                if reproductor.playing{
                    
                    reproductor.pause()
                }
            
            case "stop":
                
                if reproductor.playing{
                    
                    reproductor.stop()
                    reproductor.currentTime = 0.0
                
                }else if shuffle.playing{
                    shuffle.stop()
                    shuffle.currentTime = 0.0
                }
            
            case "shuffle":
                
 
                if !shuffle.playing{

                    reproductor.stop()
                    reproductor.currentTime = 0.0
                    
                    shuffle.play()
                    print(shuffle)
                    
                    
                    
                    
                    
                    
                    
                }

            default:
                print("")
        }
        
    }
    

    
    

}
