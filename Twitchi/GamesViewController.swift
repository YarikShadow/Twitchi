//
//  GamesViewController.swift
//  Twitchi
//
//  Created by Admin on 25.11.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var GamesCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndiactor: UIActivityIndicatorView!
    
    var refreshContol: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Games"
        GamesCollectionView.delegate = self
        GamesCollectionView.dataSource = self
        
        refreshContol = UIRefreshControl()
        refreshContol.addTarget(self, action: #selector(GamesViewController.reloadData), for: UIControlEvents.valueChanged)
        GamesCollectionView.insertSubview(refreshContol, at: 0)
        reloadData()
        
        
    }

    func reloadData() {
        
        GameDataService.instance.downloadTopGames {
            for game in GameDataService.instance.games{
                game.downloadGameImage {
                    self.GamesCollectionView.reloadData()
                    self.loadingIndiactor.stopAnimating()
                    self.refreshContol.endRefreshing()
                }
            }
        }
    }
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameDataService.instance.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as?  GameCell {
            
            let game = GameDataService.instance.games[indexPath.row]
            cell.congigurateCell(game: game)
            return cell
        } else {
            return GameCell()
        }
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let game = GameDataService.instance.games[indexPath.row]
        performSegue(withIdentifier: "streamShowVC", sender: game)
        
    }
  //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (GamesCollectionView.bounds.width / 2 ) - 15
        
        
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
    }
    
    //MARK: segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "streamShowVC" {
            if let streamVC = segue.destination as? StreamsViewController {
                if let game = sender as? Game {
                    streamVC.game = game
                }
            }
        }
    }
}


