//
//  ViewController2.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 29/02/2024.
//

import UIKit
//#Preview {
//    let articleViewController = ViewController2(nibName: nil, bundle: nil)
//    
//    return articleViewController
//}
class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.view.showIndicatorWithAutoHide(type: .success, message: "Đã thêm")
     }
}
enum IndicatorType {
    case success
    case error
    case loading
}

class CustomIndicatorView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let tickLabel: UILabel = {
        let label = UILabel()
        label.text = "✔︎"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Background setup
        backgroundColor = .clear
        
        // Add containerView
        addSubview(containerView)
        
        // Add subviews to containerView
        containerView.addSubview(activityIndicatorView)
        containerView.addSubview(tickLabel)
        containerView.addSubview(messageLabel)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.size.width - 40),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            tickLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            tickLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            tickLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
             messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Function to show the indicator with tick
    func showSuccessIndicator(message: String) {
        activityIndicatorView.stopAnimating()
        tickLabel.isHidden = false
        tickLabel.text = "✔︎"
        messageLabel.text = message
    }
    
    // Function to show the indicator with cross
    func showErrorIndicator(message: String) {
        activityIndicatorView.stopAnimating()
        tickLabel.isHidden = false
        tickLabel.text = "✘"
        messageLabel.text = message
    }
    
    // Function to show the indicator with loading animation
    func showLoadingIndicator() {
        activityIndicatorView.startAnimating()
        tickLabel.isHidden = true
        messageLabel.text = "Đang xử lý..."
    }
}
extension UIView {
    func showIndicatorWithAutoHide(type: IndicatorType, message: String, duration: TimeInterval = 3.0) {
        let indicatorView = CustomIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 200))
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
         self.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        switch type {
        case .success:
            indicatorView.showSuccessIndicator(message: message)
        case .error:
            indicatorView.showErrorIndicator(message: message)
        case .loading:
            indicatorView.showLoadingIndicator()
        }
        
        // Tự động tắt sau khoảng thời gian nhất định
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            indicatorView.removeFromSuperview()
        }
    }
}
 
class PopupView: UIView {
    
    weak var parentViewController: UIViewController?
    var messageString: String?
    
    lazy var textView: UITextView = {
        let textview = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 110))
         textview.isEditable = false
        textview.isScrollEnabled = false
        textview.font = UIFont.systemFont(ofSize: 15)
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    }()
    
    lazy var dismissButton: UIButton = {
        var dismissButton = UIButton()
        dismissButton = UIButton(type: .system)
        dismissButton.setTitle("Đóng", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        return dismissButton
    }()
    
    lazy var popupView: UIView = {
        let popupView = UIView()
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 15
        popupView.translatesAutoresizingMaskIntoConstraints = false
        return popupView
    }()
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    var textViewHeightConstraint: NSLayoutConstraint!
    
    fileprivate func setUpViewInParent(parentViewController: UIViewController) {
        parentViewController.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parentViewController.view.topAnchor),
            self.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor)
        ])
    }
    
    fileprivate func setUpBackgroundView() {
        addSubview(backgroundView)
         NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    fileprivate func setUpPopupView() {
        addSubview(popupView)
        popupView.addSubview(textView)
        popupView.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            popupView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            popupView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    fileprivate func setUpTextView() {
       
        textView.text = self.messageString
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: 0),
            textViewHeightConstraint,
        ])
    }
    
    fileprivate func setUpDismissButton() {
        NSLayoutConstraint.activate([
             dismissButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10),
            dismissButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20),
            dismissButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    fileprivate func setUpTextViewConstraint() {
        let calculatedHeight = calculateViewHeightWithCurrentWidth(textView: textView)
        textView.isScrollEnabled = calculatedHeight > UIScreen.main.bounds.size.height - 150
        textViewHeightConstraint.constant = min(calculatedHeight, UIScreen.main.bounds.size.height * 0.8)
    }
    
    func showPopup() {
        guard let parentViewController else { return }
        setUpViewInParent(parentViewController: parentViewController)
        setUpBackgroundView()
        setUpPopupView()
        setUpTextView()
        setUpDismissButton()
        setUpTextViewConstraint()
    }
    
    init(text: String, from vc: UIViewController) {
        super.init(frame: .zero)
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 150)
        self.messageString = text
        self.parentViewController = vc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismiss() {
        removeFromSuperview()
    }
    func calculateViewHeightWithCurrentWidth(textView: UITextView) -> CGFloat {
        let textWidth = textView.frame.width -
        textView.textContainerInset.left -
        textView.textContainerInset.right -
        textView.textContainer.lineFragmentPadding * 2.0 -
        textView.contentInset.left -
        textView.contentInset.right
        
        let maxSize = CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude)
        var calculatedSize = textView.attributedText.boundingRect(with: maxSize,
                                                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                      context: nil).size
        calculatedSize.height += textView.textContainerInset.top
        calculatedSize.height += textView.textContainerInset.bottom
        
        return ceil(calculatedSize.height)
    }
}

#Preview {
    let articleViewController = ViewController2(nibName: nil, bundle: nil)
    
    return articleViewController
}
protocol ProductListViewDelegate: AnyObject {
    func didSelectProduct(_ product: String)
}

class ProductListView: UIView {
    weak var delegate: ProductListViewDelegate?
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Danh Sách SP KIểm Tra Hạn Sử Dụng"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Group 25 copy"), for: .normal)
        return button
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    private var products: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // TableView
        self.layer.cornerRadius = 14
        self.clipsToBounds = false
        tableView.layer.corner(radius: 14, corners: [.bottomLeft, .bottomRight])
        searchBar.layer.cornerRadius = 14
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(mainView)
        
        mainView.addSubview(closeButton)
        
        mainView.addSubview(tableView)
        mainView.addSubview(searchBar)
        mainView.addSubview(searchBar)
        
        mainView.addSubview(titleLabel)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //Main View
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        // TITLE
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0
                                           ),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        // Button Close
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: -15),
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        // SearchBar
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func updateProducts(_ products: [String]) {
        self.products = products
        tableView.reloadData()
    }
    
    func show(inView view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
}

extension ProductListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedProduct = products[indexPath.row]
        delegate?.didSelectProduct(selectedProduct)
    }
}

extension ProductListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}


import SwiftUI

struct ContentView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                ScrollView(.vertical, showsIndicators: false) {
                    mainContentView
                }
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("Siêu thị:")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("TextColor"))
            
            Spacer()
            
            Text("NTH - 450A Thống Nhất")
                .font(.title3)
                .foregroundColor(Color("TextColor"))
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    var mainContentView: some View {
        VStack(spacing: 20) {
            dateSectionView
            
            listProductView
            
            updateButtonView
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
    
    var dateSectionView: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Ngày thực hiện:")
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
                
                Spacer()
                
                Text("12/01/2019")
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
            }
            
            HStack {
                Text("HSD tối đa cần thống kê:")
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
                
                Spacer()
                
                Text("12/01/2019")
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
            }
        }
    }
    
    var listProductView: some View {
        VStack(spacing: 10) {
            Text("Danh sách sản phẩm kiểm tra:")
                .font(.title3)
                .foregroundColor(Color("TextColor"))
            
            Divider()
            
            ForEach(0..<3, id: \.self) { index in
                productItemView(index: index)
            }
        }
    }
     var productItemView: some View  {
        HStack {
            Text("0029170020003")
                .font(.body)
                .foregroundColor(Color("TextColor"))
            
            Spacer()
            
            Text("Bánh xốp hữu cơ vị đậu hà lan và rau bina Happy Baby")
                .font(.body)
                .foregroundColor(Color("TextColor"))
            
            Spacer()
            
            Text("SL tồn: 3")
                .font(.body)
                .foregroundColor(Color("TextColor"))
            
            Spacer()
            
            Text("SL nhập: 3")
                .font(.body)
                .foregroundColor(Color("TextColor"))
        }
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
    }
    
    var updateButtonView: some View {
        Button(action: {
            // TODO: Cập nhật dữ liệu
        }) {
            Text("Cập nhật")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("ButtonColor"))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
    
    func productItemView(index: Int) -> some View { // Or any other appropriate view type
         
        HStack {
            Text("0029170020003")
                .font(.body)
                .foregroundColor(Color("TextColor"))
            
            Spacer()
            
            Text("Bánh xốp hữu cơ vị đậu hà lan và rau bina Happy Baby")
                .font(.body)
                .foregroundColor(Color("TextColor"))
            
            Spacer()
            
            Text("SL tồn: 3")
                .font(.body)
                .foregroundColor(Color("TextColor"))
            
            Spacer()
            
            Text("SL nhập: 3")
                .font(.body)
                .foregroundColor(Color("TextColor"))
        }
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
    }
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
extension UITextView {
    // Note: This will trigger a text rendering!

}
