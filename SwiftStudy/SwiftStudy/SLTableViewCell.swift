//
//  SLTableViewCell.swift
//  SwiftStudy
//
//  Created by wsl on 2019/5/29.
//  Copyright © 2019 wsl. All rights reserved.
//

import UIKit

class SLTableViewCell: UITableViewCell{
    //头像
    lazy var headImage:UIImageView = {
        let headimage = UIImageView()
        headimage.layer.cornerRadius = 15
        headimage.clipsToBounds = true
        return headimage
    }()
    //昵称
    lazy var nickLabel:UILabel = {
        let nickName = UILabel()
        nickName.textColor = UIColor.black;
        nickName.font = UIFont.systemFont(ofSize: 14)
        return nickName
    }()
    //时间和来源
    lazy var timeLabel:UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor.gray;
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        return timeLabel
    }()
    //关注
    lazy var followBtn:UIButton = {
        let followBtn = UIButton()
        followBtn.layer.borderColor = UIColor.init(red: 58/256.0, green: 164/256.0, blue: 240/256.0, alpha: 1.0).cgColor
        followBtn.layer.borderWidth = 0.5
        followBtn.layer.cornerRadius = 12
        followBtn.clipsToBounds = true
        followBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        followBtn.setTitleColor(UIColor.init(red: 58/256.0, green: 164/256.0, blue: 240/256.0, alpha: 1.0), for: UIControl.State.normal)
        followBtn.addTarget(self, action: #selector(followBtnClicked(followBtn:)), for: UIControl.Event.touchUpInside)
        followBtn.setContentCompressionResistancePriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.horizontal)
        return followBtn
    }()
    //标题
    lazy var textView:UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black;
        textView.isEditable = false;
        textView.isScrollEnabled = false;
        textView.delegate = self
//        textView.numberOfLines  = 0
        return textView
    }()
    
    //初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    // MARK: UI
    func setupUI() {
        self.contentView.addSubview(self.headImage)
        self.contentView.addSubview(self.nickLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.followBtn)
        self.contentView.addSubview(self.textView)
        self.headImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.width.equalTo(35)
        }
        self.nickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImage.snp.right).offset(5)
            make.top.equalTo(self.headImage.snp.top).offset(2)
            make.height.equalTo(20)
            make.right.lessThanOrEqualTo(self.followBtn.snp.left).offset(-5)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImage.snp.right).offset(5)
            make.top.equalTo(self.nickLabel.snp.bottom).offset(2)
            make.height.equalTo(10)
            make.right.lessThanOrEqualTo(self.followBtn.snp.left).offset(-5)
        }
        self.followBtn.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.nickLabel.snp.right).offset(5)
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.headImage.snp.centerY)
            make.height.equalTo(24)
        }
        self.textView.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImage.snp.left)
            make.right.equalTo(self.followBtn.snp.right)
            make.top.equalTo(self.headImage.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    // MARK: ReloadData
    func configureCell(model:SLModel) -> Void {
        let url = URL(string:model.headPic)
        let placeholderImage = UIImage(named: "placeholderImage")!
        //        let processor = DownsamplingImageProcessor(size: CGSize.init(width: 44, height: 44))
        //            >> RoundCornerImageProcessor(cornerRadius: 20)
        self.headImage.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        //        cell.imageView?.kf.setImage(with: url, placeholder: placeholderImage, options: [
        //            .processor(processor),
        //            .scaleFactor(UIScreen.main.scale),
        //            .transition(.fade(1)),
        //            .cacheOriginalImage
        //            ], progressBlock: { (p, k) in
        //
        //        }, completionHandler: { (Result<RetrieveImageResult1, KingfisherError>) in
        //
        //        })
        self.nickLabel.text = model.nickName
        self.timeLabel.text =  model.time! + " 来自 " + model.source!
        self.followBtn.setTitle("      关注     ", for: UIControl.State.normal)
        self.textView.attributedText = model.title
    }
    
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        //        var string = textView.text.substring(with: characterRange)
//        print("点击了")
//        return true
//    }
    
    // MARK: Events
    @objc func followBtnClicked(followBtn:UIButton) {
        print("已关注")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension SLTableViewCell : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        var string = textView.text.substring(with: characterRange)
        print("点击了链接 \(URL.absoluteString)")
        return true
    }
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("点击了附件")
        return true
    }
}
