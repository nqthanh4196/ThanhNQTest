//
//  RatingViewController.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 28/03/2024.
//

import UIKit
class ProductViewModel {
    var productName: String = ""
    var productImage: String = ""
}
class RatingStarViewModel {
    var numberStar: Int = 0
}
class RatingSelected {
    var ratingSelected: String = ""
}

struct RatingViewModel {
    enum RatingContentType {
        case productInfo(ProductViewModel)
        case ratingStar(RatingStarViewModel)
        case ratingSelected(RatingSelected)
        case ratingInput(String)
        case ratingImage(Data)
        case successRow
    }
    
    let contentString: String
    var content: RatingContentType
    
    mutating func updateContentValue(_ newValue: RatingViewModel.RatingContentType, at index: Int) {
        content = newValue
    }
}

enum RatingStatus {
    case rating
    case success
}

class RatingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
        return tableView
    }()
    var data: [[RatingViewModel]] = []
    var dataSucees: [RatingViewModel] = []
    var viewRatingStatus: RatingStatus = .success
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: "ProductRatingGiftInfoTableViewCell", bundle: .main)
        let cellNib2 = UINib(nibName: "RatingSuccessTableViewCell", bundle: .main)
        let cellNib3 = UINib(nibName: "ProductRatingSuccessTableViewCell", bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: "ProductRatingGiftInfoTableViewCell")
        tableView.register(RatingTableViewCell.self, forCellReuseIdentifier: "RatingTableViewCell")
        tableView.register(cellNib2, forCellReuseIdentifier: "RatingSuccessTableViewCell")
        tableView.register(cellNib3, forCellReuseIdentifier: "ProductRatingSuccessTableViewCell")
        tableView.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        setupData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewRatingStatus == .rating ? data.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewRatingStatus == .rating ? data[section].count : dataSucees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataModel = viewRatingStatus == .rating ? self.data[indexPath.section][indexPath.row] : self.dataSucees[indexPath.row]
        switch dataModel.content {
         case .productInfo(_):
            if viewRatingStatus == .rating {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductRatingGiftInfoTableViewCell", for: indexPath) as! ProductRatingGiftInfoTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductRatingSuccessTableViewCell", for: indexPath) as! ProductRatingSuccessTableViewCell
                return cell
            }
          
        case .ratingStar(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
            return cell
        case .ratingSelected(_):
            return UITableViewCell()
        case .ratingInput(_):
            return UITableViewCell()
        case .ratingImage(_):
            return UITableViewCell()
        case .successRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingSuccessTableViewCell", for: indexPath) as! RatingSuccessTableViewCell
            return cell
        }
    }
    
    func setupData() {
        data = [
            [RatingViewModel(contentString: "Đánh giá thật hay, nhận ngay Voucher 50K", content: .productInfo(ProductViewModel.init())),
             
             RatingViewModel(contentString: "", content: .ratingStar(RatingStarViewModel.init())),
             
             RatingViewModel(contentString: " ", content: .ratingSelected(RatingSelected.init())),
             
             RatingViewModel(contentString: " ", content: .ratingInput("")),
             
             RatingViewModel(contentString: "Đánh giá thật hay, nhận ngay Voucher 50K", content: .ratingImage(Data())),
            ]
        ]
        
        dataSucees = [
            RatingViewModel(contentString: " ", content: .successRow),
            RatingViewModel(contentString: "Đánh giá thật hay, nhận ngay Voucher 50K", content: .productInfo(ProductViewModel.init())),
        ]
        
    }
}
#Preview {
    let articleViewController = RatingViewController()
    
    return articleViewController
}






class RatingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    /// Create a variable in which we will store the current rating Int
    private var selectedRate: Int = 0
    
    /// Adding a Selection Feedback effect to clicking on a star
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    // MARK: - User Interface
    
    private lazy var starsContainer: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        /// Adding a UITapGestureRecognizer to our stack of stars to handle clicking on a star
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        stackView.addGestureRecognizer(tapGesture)
        
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createStars()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - User Action
    
    @objc private func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starsContainer)
        let starWidth = starsContainer.bounds.width / CGFloat(Constants.starsCount)
        let rate = Int(location.x / starWidth) + 1
        
        /// if current star doesn't match selectedRate then we change our rating
        if rate != self.selectedRate {
            feedbackGenerator.selectionChanged()
            self.selectedRate = rate
        }
        
        /// loop through starsContainer arrangedSubviews and
        /// look for all Subviews of type UIImageView and change
        /// their isHighlighted state (icons depend on it)
        starsContainer.arrangedSubviews.forEach { subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            starImageView.isHighlighted = starImageView.tag <= rate
        }
    }
    // MARK: - Private methods
    
    private func createStars() {
        /// loop through the number of our stars and add them to the stackView (starsContainer)
        for index in 1...Constants.starsCount {
            let star = makeStarIcon()
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
    }
    
    private func makeStarIcon() -> UIImageView {
        /// declare default icon and highlightedImage
        let imageView = UIImageView(image: UIImage(named: "icon_unfilled_star"), highlightedImage: UIImage(named: "icon_filled_star2"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    private func setupUI() {
        /// star container
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        starsContainer.heightAnchor.constraint(equalToConstant: Constants.starContainerHeight).isActive = true
        /// Add subviews
        contentView.addSubview(starsContainer)
        /// Layout constraints
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            starsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            starsContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starsContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            starsContainer.widthAnchor.constraint(equalToConstant: 220),
            starsContainer.heightAnchor.constraint(equalToConstant: Constants.starContainerHeight)
        ])
        
        
    }
    
    // MARK: - Constants {
    
    private struct Constants {
        static let starsCount: Int = 5
        static let starContainerHeight: CGFloat = 36
    }
}
extension UIView {
    func addPulsationAnimation() {
        /// transparency animation
        /// you can pick any values you like
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1.5
        pulseAnimation.fromValue = 0.7
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: nil)
        
        /// transform scale animation
        /// you can pick any values you like
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 1.5
        scaleAnimation.fromValue = 0.95
        scaleAnimation.toValue = 1
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(scaleAnimation, forKey: nil)
    }
}
