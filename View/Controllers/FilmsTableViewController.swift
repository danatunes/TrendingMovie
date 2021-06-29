//
//  FilmsTableViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 18.04.2021.
//

import UIKit
import Alamofire

class FilmsTableViewController: UIViewController{
    
    public var titleOfPage : String?
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    static public var movie : MovieCustom.Movie!
    
    private var filmsPresenter : FilmsPresenter!
    
    private var comedy : [MovieCustom.Movie] = [MovieCustom.Movie]() {
        didSet {
            print(",,, im here \(movies)")
            filteredData = movies
        }
    }
    
    private var fantastic : [MovieCustom.Movie] = [MovieCustom.Movie]() {
        didSet {
            print(",,, im here \(movies)")
            filteredData = movies
        }
    }
    
    private var horror : [MovieCustom.Movie] = [MovieCustom.Movie]() {
        didSet {
            print(",,, im here \(movies)")
            filteredData = movies
        }
    }
    
    private var adventure : [MovieCustom.Movie] = [MovieCustom.Movie]() {
        didSet {
            print(",,, im here \(movies)")
            filteredData = movies
        }
    }
    
    private var crime : [MovieCustom.Movie] = [MovieCustom.Movie]() {
        didSet {
            print(",,, im here \(movies)")
            filteredData = movies
        }
    }
    
    private var war : [MovieCustom.Movie] = [MovieCustom.Movie]() {
        didSet {
            print(",,, im here \(movies)")
            filteredData = movies
        }
    }
    
    
    private var movies : [MovieCustom.Movie] = [MovieCustom.Movie]() {
        didSet {
            print(",,, im here \(movies)")
            filteredData = movies
        }
    }
    
    
    private var filteredData : [MovieCustom.Movie] = [MovieCustom.Movie](){
        didSet {
            tableView.reloadData()
            print(",,,, movie custom \(filteredData)")
        }
    }
    
    
    let searchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleOfPage ?? "Movies"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        
        tableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        
        searchBar.delegate = self
        
        initializeFilms()
        sortByGenre()
    }
    
    private func sortByGenre(){
        print(".,.,., sort by Genre")
        movies.map { (movie)  in
            print(".,.,., \(movie)")
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    private func initializeFilms(){
        filmsPresenter = FilmsPresenter(self)
        filmsPresenter.fetchMovieFromAPI()
    }
}


extension FilmsTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
        vc.oneMovie = movies[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        cell.movie = filteredData[indexPath.row]
        
        return cell
    }
    
}

extension FilmsTableViewController : FilmsPresenterDelegate{
    
    func fetchMovie(_ movies: [MovieCustom.Movie]) {
        self.movies = movies
    }

}

extension FilmsTableViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == "" {
            filteredData = movies
        }
        
        for name in movies{
            if name.movie.name.uppercased().contains(searchText.uppercased()) {
                filteredData.append(name)
            }
        }
        
    }
}
