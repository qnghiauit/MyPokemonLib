//
//  MainViewController.swift
//  MyPokemonLib
//
//  Created by Quang Nghia on 5/10/17.
//  Copyright © 2017 Quang Nghia. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var clPokes: UICollectionView!
    @IBOutlet weak var sbFilter: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filterPokemos = [Pokemon]()
    var isSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        initAudio()
        
        clPokes.delegate = self
        clPokes.dataSource = self
        sbFilter.delegate = self
        parsePokemonDataFromCsvFile()
    }
    
    func initAudio() {
        do {
            if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
                musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
                
                musicPlayer.numberOfLoops = -1
                
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
                try AVAudioSession.sharedInstance().setActive(true)
                
                musicPlayer.prepareToPlay()
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
            pokemons.sort(by: {$0.id < $1.id})
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = clPokes.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell {
            var pokemon : Pokemon
            if isSearchMode {
                pokemon = filterPokemos[indexPath.row]
            } else {
                pokemon = pokemons[indexPath.row]
            }
            cell.fillData(pokemon)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchMode {
            return filterPokemos.count
        } else {
            return pokemons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemon : Pokemon
        if isSearchMode {
            pokemon = filterPokemos[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "ShowDetailViewSegue", sender: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if sbFilter.text == nil || (sbFilter.text?.isEmpty)! {
            isSearchMode = false
            view.endEditing(true)
        } else {
            isSearchMode = true
            let lowerText = sbFilter.text?.lowercased()
            filterPokemos = pokemons.filter({$0.name.range(of: lowerText!) != nil})
        }
        clPokes.reloadData()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailViewSegue" {
            if let detailViewController = segue.destination as? DetailViewController {
                if let pokemon = sender as? Pokemon {
                    detailViewController.pokemon = pokemon
                }
            }
        }
        
        
    }
    
}

