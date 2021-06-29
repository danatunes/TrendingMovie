//
//  FilmsCellTableViewCell.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 19.04.2021.
//

import UIKit
import Kingfisher

protocol MovieCellProtocol : NSObjectProtocol {
    func reloadStarFromFavorite()
}

class MovieCell: UITableViewCell {
    
    static let identifier = String(describing: MovieCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var ratingContainer: UIView!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    weak var delegate : MovieCellProtocol?
    
    public var movieDTO : MovieDTO? {
        didSet{
            if let movie = movieDTO{
                
                if let poster = movie.poster{
                    let url = URL(string: "https://image.tmdb.org/t/p/w300\(poster)")
                    let processor = DownsamplingImageProcessor(size: posterImageView.bounds.size)
                        |> RoundCornerImageProcessor(cornerRadius: 20)
                    posterImageView.kf.indicatorType = .activity
                    posterImageView.kf.setImage(
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
                    
                }
                
                ratingLabel.text = "\(String(describing: movie.rating))"
                
                
                movieTitleLabel.text = movie.title
                releaseDateLabel.text = movie.releaseDate
                
                if let movieIsLike = CoreDataManager.shared.findMovie(with: movie.id){
                    favoriteButton.setImage(UIImage(named: "starFilled"), for: .normal)
//                    if movieIsLike.isLike == true {
//                        favoriteButton.setImage(UIImage(named: "starFilled"), for: .normal)
//                    }
                }else{
                    favoriteButton.setImage(UIImage(named: "star"), for: .normal)
                }
            }
        }
    }
    
    public var movie : MovieCustom.Movie? {
        didSet{
            if let movie = movie{
                
                //                guard let poster = movie.poster else {
                //                    print("... poster nil")
                //                    return
                //                }
                 let poster = movie.movie.imgUrl
                    let url = URL(string: "https://image.tmdb.org/t/p/w300\(poster)")
                    let processor = DownsamplingImageProcessor(size: posterImageView.bounds.size)
                        |> RoundCornerImageProcessor(cornerRadius: 20)
                    posterImageView.kf.indicatorType = .activity
                    posterImageView.kf.setImage(
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
                    
                
                
                ratingLabel.text = "\(String(describing: movie.movie.ageRating))"
                
                
                movieTitleLabel.text = movie.movie.name
                releaseDateLabel.text = movie.movie.releaseDate
                
                if let _ = CoreDataManager.shared.findMovie(with: movie.movie.id ){
                    favoriteButton.setImage(UIImage(named: "starFilled"), for: .normal)
                }else{
                    favoriteButton.setImage(UIImage(named: "star"), for: .normal)
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        posterImageView.layer.cornerRadius = 12
        posterImageView.layer.masksToBounds = true
        
        ratingContainer.layer.cornerRadius = 20
        ratingContainer.layer.masksToBounds = true
        
        //favoriteButton.isHidden = true
    }
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        //        print(".... favorite button pressed")
        if var movie = movieDTO{
            if let _ = CoreDataManager.shared.findMovie(with: movie.id){
                CoreDataManager.shared.deleteMovie(with: movie.id)
                sender.setImage(UIImage(named:"star"), for: .normal)
                delegate?.reloadStarFromFavorite()
                //print("..... if let inside movie = movie")
            }else{
                movie.isLike = true
                CoreDataManager.shared.addMovie(movie)
                sender.setImage(UIImage(named: "starFilled"), for: .normal)
                //print("..... else let inside movie = movie")
            }
        }
        if let movie = movie{
            if let _ = CoreDataManager.shared.findMovie(with: movie.movie.id){
                CoreDataManager.shared.deleteMovie(with: movie.movie.id)
                sender.setImage(UIImage(named:"star"), for: .normal)
                delegate?.reloadStarFromFavorite()
                //                print("..... if let inside movie = movie")
            }else{
                CoreDataManager.shared.addMovie(movie)
                sender.setImage(UIImage(named: "starFilled"), for: .normal)
                // print("..... else let inside movie = movie")
            }
        }
    }
    
}
