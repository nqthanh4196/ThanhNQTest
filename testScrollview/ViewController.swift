//
//  ViewController.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 22/02/2024.
//

import UIKit


import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
         return tableView
    }()
    var data: [CustomCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
         NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        setupData()
    }

    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let viewModel = data[indexPath.row]
        cell.configure(viewModel: viewModel)
        if indexPath.row == 0 {
            cell.mainContentStackView.layer.corner(radius: 20, corners: [.topLeft, .topRight])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.row].content = .label("ok ")
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
 
    func setupData() {
        data = [
            CustomCellViewModel(title: "Mã SP:", content: .labelWithIcon("Chọn mã sản phẩm cần thống kê")),
            CustomCellViewModel(title: "Tên SP:", content: .label(" ")),
            CustomCellViewModel(title: "Ngành hàng:", content: .label(" ")),
            CustomCellViewModel(title: "Đơn vị tính:", content: .label(" ")),
            CustomCellViewModel(title: "Số lượng SP cùng NSX, HSD:", content: .textField("")),
            CustomCellViewModel(title: "NSX:", content: .labelWithIcon("Chọn ngày sản xuất")),
            CustomCellViewModel(title: "HSD:", content: .labelWithIcon("Chọn hạn sử dụng")),
            CustomCellViewModel(title: "Hình ảnh: chụp rõ NSX, HSD", content: .image([])),
            
           
         ]
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footerView.backgroundColor = .clear
        
        let buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(buttonContainer)
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Xóa", for: .normal)
         deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.backgroundColor = .white
        deleteButton.layer.corner(radius: 20, corners: [.bottomLeft, .bottomRight])
        deleteButton.addTarget(self, action: #selector(deleteSectionButtonTapped(_:)), for: .touchUpInside)
        deleteButton.tag = section
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            buttonContainer.topAnchor.constraint(equalTo: footerView.topAnchor),
            buttonContainer.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            buttonContainer.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10),
            buttonContainer.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -10),
            
            deleteButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40) // A height constraint for button
        ])
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    @objc func deleteSectionButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        // Thực hiện hành động xóa phần đó
        // Ví dụ:
        // data.remove(at: section)
        // tableView.deleteSections(IndexSet(integer: section), with: .automatic)
    }
    
    
}

class CustomTableViewCell: UITableViewCell {
    
    // Title label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var mainContentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        return stackview
    }()
    
    // Content label
    lazy var contentTralingView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fill
        return stackview
    }()
    
    lazy var labelContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    lazy var textFiledInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray.withAlphaComponent(0.3)
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var titleLabelWidthConstraint: NSLayoutConstraint = {
        var constraint = NSLayoutConstraint()
        constraint = titleLabel.widthAnchor.constraint(equalToConstant: 30)
        return constraint
    }()
    
    lazy var topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    
    lazy var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.delegate = self
         collectionView.dataSource = self
         // Configure your collection view here (e.g., register cells)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.isHidden = true
        
          return collectionView
     }()
    
    var collectionData: [String] = [ ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        topContentView.backgroundColor = .white
            contentView.addSubview(mainContentStackView)
          mainContentStackView.addArrangedSubview(topContentView)
         // Add subviews
        topContentView.addSubview(titleLabel)
        topContentView.addSubview(contentTralingView)
        
        contentTralingView.addArrangedSubview(labelContent)
        contentTralingView.addArrangedSubview(textFiledInput)
        NSLayoutConstraint.activate([
            mainContentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainContentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         ])
        
        // Title label constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo:  topContentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo:  topContentView.bottomAnchor, constant: -8),
            titleLabelWidthConstraint
        ])
        
        // Content label constraints
        NSLayoutConstraint.activate([
            contentTralingView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            contentTralingView.trailingAnchor.constraint(equalTo:  topContentView.trailingAnchor, constant: -16),
            contentTralingView.topAnchor.constraint(equalTo:  topContentView.topAnchor, constant: 8),
            contentTralingView.bottomAnchor.constraint(equalTo:  topContentView.bottomAnchor, constant: -8)
        ])
    } 
    
    func setUpCollectionView() {
        mainContentStackView.addArrangedSubview(collectionView)
        collectionView.isHidden = true
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withTitle title: String, content: String) {
        titleLabel.text = title
        labelContent.text = content
        if content.isEmpty {
            labelContent.isHidden = true
            textFiledInput.isHidden = false
        } else {
            labelContent.isHidden = false
            textFiledInput.isHidden = true
        }
        titleLabelWidthConstraint.constant = min(titleLabel.width, (UIScreen.main.bounds.width / 2) - 32)
    }
    //CustomCellViewModel
    func configure(viewModel: CustomCellViewModel) {
        titleLabel.text = viewModel.title
        
        switch viewModel.content {
        case .label(let string):
            labelContent.isHidden = false
            textFiledInput.isHidden = true
            collectionView.isHidden = true
            labelContent.text = string
            titleLabelWidthConstraint.constant = min(titleLabel.width, (UIScreen.main.bounds.width / 2) - 32)
        case .textField(_):
            labelContent.isHidden = true
            textFiledInput.isHidden = false
            collectionView.isHidden = true
            titleLabelWidthConstraint.constant = min(titleLabel.width, (UIScreen.main.bounds.width / 2) - 32)
        case .labelWithIcon(let string):
            labelContent.isHidden = false
            textFiledInput.isHidden = true
            collectionView.isHidden = true
            let image = UIImage(named: "Vector")!
            let imageSize = CGSize(width: 15, height: 10)
            let textColor = UIColor.black
            let font = UIFont.systemFont(ofSize: 14)

            let attributedString = NSAttributedString.attributedString(withText: string,
                                                                       andImage: image,
                                                                       at: imageSize,
                                                                       textColor: textColor,
                                                                       font: font)
            
            labelContent.attributedText = attributedString
            titleLabelWidthConstraint.constant = min(titleLabel.width, (UIScreen.main.bounds.width / 2) - 32)
        case .image(let imageData):
            setUpCollectionView()
            labelContent.isHidden = true
            textFiledInput.isHidden = true
            collectionView.isHidden = false
            titleLabelWidthConstraint.constant = UIScreen.main.bounds.width - 36
        case .delete:
             labelContent.isHidden = true
            textFiledInput.isHidden = true
            collectionView.isHidden = true
            titleLabel.isHidden = true
           }
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.isHidden = true
     }
 }
extension CustomTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        // If it's the first cell, display camera icon
        if indexPath.item == 0 {
            cell.configure(withImage: nil)
        } else {
            // Otherwise, display the user-captured image
            let index = indexPath.item - 1
            cell.configure(withImage: UIImage(named: collectionData[index]))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    }
}
#Preview {
    let articleViewController = ViewController(nibName: nil, bundle: nil)
    
    return articleViewController
}

extension UILabel {
    var width: CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: frame.height)
        let textWidth = self.sizeThatFits(maxSize).width
        return textWidth
    }
}


struct CustomCellViewModel {
    enum ContentType {
        case label(String)
        case textField(String)
        case labelWithIcon(String)
        case image([Data])
        case delete
    }
    
    let title: String
    var content: ContentType
    
    mutating func updateContentValue(_ newValue: CustomCellViewModel.ContentType, at index: Int) {
       content = newValue
    }
}

extension NSAttributedString {
    static func attributedString(withText text: String, andImage image: UIImage, at imageSize: CGSize, textColor: UIColor, font: UIFont) -> NSAttributedString {
        // Create attachment with image
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: .zero, size: imageSize)
        
        // Create attributed string with attachment
        let attributedString = NSMutableAttributedString(attachment: attachment)
        
        // Add text with specified attributes
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: font
        ]
        
        let textAttributedString = NSAttributedString(string: text + " ", attributes: textAttributes)
         attributedString.insert(textAttributedString, at: 0)
        
        return attributedString
    }
}
extension NSAttributedString {
    func appendingSpace() -> NSAttributedString {
        let spaceString = NSAttributedString(string: " ", attributes: attributes(at: length - 1, effectiveRange: nil))
        let mutableAttributedString = NSMutableAttributedString(attributedString: self)
        mutableAttributedString.append(spaceString)
        return NSAttributedString(attributedString: mutableAttributedString)
    }
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    // ImageView to display either camera icon or user-captured image
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configure imageView
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Configure cell with camera icon or user-captured image
    func configure(withImage image: UIImage?) {
        if let image = image {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "camera.fill")
        }
    }
}
extension UIView {
    func roundBottomCorners(radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
 
extension CALayer {
    func corner(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        if #available(iOS 11.0, *) {
            masksToBounds = true
            cornerRadius = radius
            maskedCorners = corners.caCornerMask
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            mask = shapeLayer
            setNeedsDisplay()
        }
    }
}

extension UIRectCorner {
    /// convert UIRectCorner to CACornerMask
    var caCornerMask: CACornerMask {
        var cornersMask = CACornerMask()
        if self.contains(.topLeft) {
            cornersMask.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            cornersMask.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            cornersMask.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            cornersMask.insert(.layerMaxXMaxYCorner)
        }
        return cornersMask
    }
}




