//
//  ChosenViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 14.04.2021.
//

import UIKit

class ChosenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    public var arrOfLike : [MovieDTO] = [] {
        didSet{
            if arrOfLike.count != oldValue.count{
                tableView.reloadData()
        }
    }
}
    
    private var chosenPresenter : ChosenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
    
        tableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializePresenter()
        fetchAllFavoriteMovies()
    }
    
    private func initializePresenter(){
        chosenPresenter = ChosenPresenter(self)
    }
    
    private func fetchAllFavoriteMovies(){
        chosenPresenter?.fetchAllMovies()
    }
}

//MARK: -UITableViewDataSource
extension ChosenViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfLike.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        cell.movieDTO = arrOfLike[indexPath.row]
        cell.delegate = self
        
        return cell
    }
}


extension ChosenViewController : MovieCellProtocol {
    func reloadStarFromFavorite() {
        fetchAllFavoriteMovies()
    }
}

extension ChosenViewController : ChosenPresenterDelegate{
    func fetchMovies(_ movies: [MovieDTO]) {
        arrOfLike = movies
    }
}
