//
//  MainViewController.swift
//  MyPokemonLib
//
//  Created by Quang Nghia on 5/10/17.
//  Copyright © 2017 Quang Nghia. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var clPokes: UICollectionView!
    
    var pokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        initAudio()
        
        clPokes.delegate = self
        clPokes.dataSource = self
        parsePokemonDataFromCsvFile()
    }
    
    func initAudio() {
        do {
            if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
                musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
                musicPlayer.prepareToPlay()
                musicPlayer.numberOfLoops = -1
                musicPlayer.play()
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonDataFromCsvFile() {
        let pathCsvFile = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: pathCsvFile!)
            let row = csv.rows
            for item in row {
                let pokemon = Pokemon()
                if let id = item["id"] {
                    pokemon.id = Int(id)!
                }
                if let name = item["identifier"] {
                    pokemon.name = name
                }
                pokemons.append(pokemon)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = clPokes.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell {
            let pokemon = pokemons[indexPath.row]
            cell.fillData(pokemon)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func btnMusicPressed(_ sender: Any) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            (sender as! UIButton).alpha = 0.6
        } else {
            musicPlayer.play()
            (sender as! UIButton).alpha = 1.0
        }
    }
    
}

