//
//  DetailsViewController.swift
//  My_beginner_Spotify
//
//  Created by Gandhi Mena Salas on 09/02/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class DetailsViewController: UIViewController,AVAudioPlayerDelegate {
    
//************Variables
    
    //variables para la playlist
    var tituloCancion:String?
    var autorCancion: String?
    var nombreportada: String?
    var audioCancion: String?
    
    //variables para el shuffle
    let listaTitulos: [String] = ["Bajo Short","Baroque Coffee House","Leslie's Struct","Far Away","Cartoon Bank","TimedOut"]
    let listaAutores: [String] = ["AudioNautix","Doug Maxwell","Jhon Deley","MK2","Doug Maxwell","Jingle Punk"]
    let listaPortadas: [String] = ["image1","image2","image3","image4","image5","image6",]
    let listaCanciones: [String] =  ["sound1", "sound2", "sound3", "sound4", "sound5", "sound6"]
    
    //Declaración de AVAudioPlayer
    var reproductor = AVAudioPlayer()
    var shuffle = AVAudioPlayer()

//*************Outlets
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    @IBOutlet weak var volumen: UISlider!
    
    
    

//************ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Volumen del dispositivo
        /*
        let wrapperView = UIView(frame: CGRectMake(45, 510, 230, 20))
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(wrapperView)
        let volumenView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumenView)
        */
        
        //Asignacion de titulo y autor seleccionados de la playlista
        titulo.text = tituloCancion
        autor.text = autorCancion
        
        // url de portada, audio seleccionados de la playlist
        let imgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(nombreportada, ofType: "jpg")!)
        let imgData = NSData(contentsOfURL: imgUrl) //convrtiendo en data la imagen
        
        let cancionDir = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(audioCancion, ofType: "mp3")!)
        
        
        do{
            
            
            try reproductor = AVAudioPlayer(contentsOfURL: cancionDir)
            reproductor.play()
            
            portada.image = UIImage(data: imgData!)
            
            
        }catch{
            
        }

    }

//**********Volumen con slider
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        let selectedValue = Float(sender.value)
        
        if reproductor.playing{
            
            reproductor.volume = selectedValue
        }else if (reproductor.playing || shuffle.playing != false){
            
            shuffle.volume = selectedValue
        }
        
        
        
        
    }
    
//***********Botones de reproducción
    @IBAction func reproducirMusica(sender: UIButton) {
        
        let botones:String = (sender.titleLabel?.text)!
        
        switch botones {
            
            case "play":
                
                if !reproductor.playing{
                    
                    reproductor.play()
                    
                    
                }else if reproductor.playing{
                    reproductor.stop()
                    reproductor.currentTime = 0.0
                    reproductor.play()
                }else if shuffle.playing{
                    
                    shuffle.stop()
                    reproductor.currentTime = 0.0
                    shuffle.play()
                }
            
            
            case "pause":
                
                if reproductor.playing{
                    
                    reproductor.pause()
                    
                }else if shuffle.playing{
                    
                    shuffle.pause()
                    
                }else if !shuffle.playing || !reproductor.playing{
                    
                    reproductor.stop()
                    reproductor.currentTime = 0.0
                    shuffle.stop()
                    shuffle.currentTime = 0.0
                }
            
            case "stop":
                
                if reproductor.playing{
                    
                    reproductor.stop()
                    reproductor.currentTime = 0.0
                
                }else if shuffle.playing{
                    
                    shuffle.stop()
                    shuffle.currentTime = 0.0
            
                }
            
            default: //este es shuffle
                
                
                let random: Int = Int (arc4random_uniform(6))//random
                
                // url de audio y portada random
                let shuffleAudioUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaCanciones[random], ofType: "mp3")!)
                let shuffleImgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaPortadas[random], ofType: "jpg")!)
                let shufflaImgData = NSData(contentsOfURL: shuffleImgUrl)
                
                do{
                    //si se presiona shuffle tanto play como shuffle obtienen el mismo valor del random
                    try shuffle = AVAudioPlayer(contentsOfURL: shuffleAudioUrl)
                    try reproductor = AVAudioPlayer(contentsOfURL: shuffleAudioUrl)
                    
                    portada.image = UIImage(data: shufflaImgData!)
                    
                    //obtienen el mismo valor del random
                    titulo.text = listaTitulos[random]
                    autor.text = listaAutores[random]
                    
                }catch{
                    
                }
            
                
                if !shuffle.playing{
                    
                    reproductor.stop()
                    reproductor.currentTime = 0.0
                    
                    shuffle.play()
                    
                }else{
                    
                    shuffle.stop()
                    shuffle.currentTime = 0.0
                }
            
        }
        
    }
    

}
