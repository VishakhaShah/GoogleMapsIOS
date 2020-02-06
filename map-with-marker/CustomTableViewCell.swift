import UIKit

class CustomTableViewCell: UITableViewCell {
    
   
    lazy var backView: UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()
    
    lazy var lbl: UILabel = {
       let lbl = UILabel(frame: CGRect(x: 10, y: 10, width: self.frame.width, height: 30))
        lbl.font = lbl.font.withSize(12)
        lbl.numberOfLines = 2
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
//        backView.addSubview(settingImage)
//        print(lbl)
        backView.addSubview(lbl)
        // Configure the view for the selected state
    }

}
