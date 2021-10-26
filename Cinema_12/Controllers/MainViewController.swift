//
//  MainViewController.swift
//  Cinema_12
//
//  Created by Преподаватель on 22.10.2021.
//

import UIKit
import AVKit
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: UICollectionView!
    @IBOutlet weak var trendView: UIView!
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var forMeView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    let player = AVPlayer()
    let playerController = AVPlayerViewController()
    var film = Film()
    var films = Film().getAllFilms()
    let cover = Cover().getCover()
    var color = UIColor()
    var vkladka: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = trendView.backgroundColor!
        posterImageView.image = UIImage.imageForString(url: cover!.foregroundImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBAction func trendButton(_ sender: Any) {
        setVkladka(0)
        
        films = film.getAllFilms(filter: .inTrend)
        filmCollectionView.reloadData()
    }
    @IBAction func newButton(_ sender: Any) {
        setVkladka(1)
        
        films = film.getAllFilms(filter: .new)
        filmCollectionView.reloadData()
    }
    @IBAction func forMeButton(_ sender: Any) {
        setVkladka(2)
        
        films = film.getAllFilms(filter: .forMe)
        filmCollectionView.reloadData()
    }
    
    private func playVideo() {
        present(playerController, animated: true) {
            self.player.play()
        }
    }
    
    func setVkladka(_ position: Int){
        if position == 0{
            
            trendView.backgroundColor = color
            newView.backgroundColor = .clear
            forMeView.backgroundColor = .clear
        }else if position == 1{
            
            trendView.backgroundColor = .clear
            newView.backgroundColor = color
            forMeView.backgroundColor = .clear
        }else if position == 2{
            
            trendView.backgroundColor = .clear
            newView.backgroundColor = .clear
            forMeView.backgroundColor = color
        }
        
    }
}

extension MainViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCollectionViewCell", for: indexPath) as! FilmCollectionViewCell
        cell.posterImageView.image = UIImage.imageForString(url: films![indexPath.item].poster)
        
        return cell
    }
    
}
