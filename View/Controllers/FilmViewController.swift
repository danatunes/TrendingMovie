//
//  FilmViewController.swift
//
//
//  Created by Магжан Бекетов on 21.04.2021.
//

import UIKit
import Kingfisher
import youtube_ios_player_helper


class FilmViewController: UIViewController {
        
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var labelForNavTitle: UILabel!
    @IBOutlet weak var viewForTable: UIView!
    @IBOutlet weak var viewForAbout: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var tableView: UITableView!
    
    
    public var oneMovie : MovieCustom.Movie?
    private var isLike : Bool = false
    var comments = [Commentator]()
    
    private var filmPresenter: FilmPresenter!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForTable.isHidden = true
        viewForAbout.isHidden = false
        initializeFilmPresenter()
        setUpData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView
            .register(CommentCell.nib, forCellReuseIdentifier: CommentCell.identifier)
        
        vidoeTrailer()
    }
    
    private func vidoeTrailer(){
        videoView.isHidden = true
        
        guard let trailerId = oneMovie?.movie.youtubeTrailerKey else{
            return
        }
        
        videoView.load(withVideoId: "\(trailerId)" ,
                       playerVars : ["playsinline" : 1])
    }
    
    private func initializeFilmPresenter(){
        filmPresenter = FilmPresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movieId = oneMovie?.movie.id{
            
            if let _ = filmPresenter.findMovie(with: movieId){
                favoriteButton.setImage(UIImage(named:"starFilled"), for: .normal)
            }else{
                favoriteButton.setImage(UIImage(named: "star"), for: .normal)
            }
        }
    }
    
    private func setUpData(){
        if let movie = oneMovie{
            
            let poster = movie.movie.imgUrl
                
            
            let url = URL(string: "https://image.tmdb.org/t/p/w400\(poster)")
            let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(3)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
            
            ratingLabel.text = "Age rating : \(movie.movie.ageRating)"
            titleLabel.text = "Movie title : \(movie.movie.name)"
            releaseDateLabel.text = "Release date : \(movie.movie.releaseDate)"
            descriptionLabel.numberOfLines = 0
            descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            descriptionLabel.text = "Overview : \(movie.movie.description)"
            labelForNavTitle.text = movie.movie.name
            
        }
    }
    
    @IBAction func watchMovieOrTrailer(_ sender: UIButton) {
    
        if videoView.isHidden{
            videoView.isHidden = false
            sender.setImage(UIImage(named: "imageIcon"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "video"), for: .normal)
            videoView.isHidden = true
        }
    }
    
    @IBAction func addComment(_ sender: UIButton) {
        print(".... taped fucking btn")
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
       
       alertController.addTextField { (textField) in
           textField.placeholder = "New item name"
       }
       
       let alertAction1 = UIAlertAction(title: "Cancel", style: .destructive) { (alert) in
       
       }
       
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
          
           let newTitle = alertController.textFields![0].text
            guard let email = ProfileViewController.user?.email else{
                print("... email nil")
                return
            }
            
            guard let newThingList = newTitle else {
                return
            }
           
            self.comments.append(Commentator(email: email, comment: newThingList))
           self.tableView.reloadData()
       }
       
       alertController.addAction(alertAction1)
       alertController.addAction(alertAction2)
       present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func changeToAbout(_ sender: UIButton) {
        viewForTable.isHidden = true
        viewForAbout.isHidden = false
    }
    @IBAction func changeToFeedback(_ sender: UIButton) {
        viewForTable.isHidden = false
        viewForAbout.isHidden = true
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        if let movieId = oneMovie?.movie.id{
            if let _ = filmPresenter.findMovie(with: movieId){
                filmPresenter.deleteMovie(with: movieId)
                favoriteButton.setImage(UIImage(named:"star"), for: .normal)
            }else{
                if var details = oneMovie{
                    details.movie.id = movieId
                    filmPresenter.addMovie(movie: details)
                    favoriteButton.setImage(UIImage(named: "starFilled"), for: .normal)
                }
            }
        }
    }
}

extension FilmViewController : UITableViewDelegate{
    
}

extension FilmViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier , for: indexPath) as! CommentCell
        cell.commentator = comments[indexPath.row]
        return cell
    }
    
    
}

extension FilmViewController : FilmPresenterDelegate{
   
    
}
