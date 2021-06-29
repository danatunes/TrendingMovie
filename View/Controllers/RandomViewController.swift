//
//  RandomViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 12.06.2021.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var letsRandom: UIButton!
    
    public var arr : MovieCustom.Movie?{
        didSet{
            tableView.isHidden = false
            //letsRandom.isHidden = true
            tableView.reloadData()
        }
    }
    
    private var movieArr : [MovieCustom.Movie] = [MovieCustom.Movie](){
        didSet{
            print("33333 \(movieArr)")
        }
    }
    
    private var randomPresenter : RandomPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        letsRandom.layer.cornerRadius = 20
        letsRandom.layer.masksToBounds = true
        
        
        tableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        initializeRandomPresenter()
        getTrendingMovies()
        
    }
    
    private func initializeRandomPresenter(){
        randomPresenter = RandomPresenter(self)
    }
    
    @IBAction func letsRandomAction(_ sender: Any) {
        
        getRandom()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func getTrendingMovies() {
        randomPresenter?.fetchMovieFromAPI()
    }
    
    public func getRandom(){
        
        arr = nil
        var movie = movieArr.randomElement()
        //        print("22222 \(movie)")
        arr = movie
        movie = nil
    }
    
}

extension RandomViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        cell.movie = arr
        
        return cell
    }
    
    
}

extension RandomViewController : RandomPresenterDelegate {
    func fetchMovie(_ movies: [MovieCustom.Movie]) {
        self.movieArr = movies
    }
}
