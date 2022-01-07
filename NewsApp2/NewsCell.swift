import UIKit
import SnapKit

class NewsCell: UITableViewCell {
    
    
    var newsTitle = UILabel()
    var newsDescriptions = UILabel()
    var newsImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(newsTitle)
        backgroundColor = UIColor.systemGray
        
        newsTitle.snp.makeConstraints {make in
            make.top.left.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().dividedBy(2)
        }
        addSubview(newsDescriptions)
        newsDescriptions.snp.makeConstraints{make in
            make.top.equalTo(newsTitle.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().dividedBy(2)
        }
        addSubview(newsImage)
        newsImage.snp.makeConstraints{ make in
            make.centerY.right.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        configureImageView()
        configureNewsTitle()
        configureNewsDescriptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        newsImage.layer.cornerRadius = 10
        newsImage.clipsToBounds = true
    }
    func configureNewsTitle() {
        newsTitle.numberOfLines = 0
        newsTitle.adjustsFontSizeToFitWidth = true
        newsTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    func configureNewsDescriptions() {
        newsDescriptions.numberOfLines = 0
        newsDescriptions.adjustsFontSizeToFitWidth = true
        newsDescriptions.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    }
