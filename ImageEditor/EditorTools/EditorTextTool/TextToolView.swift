import Foundation

class TextToolView : UIView {
    
    @IBOutlet weak var editAreaView: UIView!
    
    var overlayViews : Array<IQLabelView>
    
    required init(coder aDecoder: NSCoder) {
        overlayViews = Array()
        super.init(coder: aDecoder)
    }
    
    func initView() -> UIView {
        let nib = UINib(nibName: "TextToolView", bundle: nil)
        let views = nib.instantiateWithOwner(self, options: nil)
        return views[0] as UIView
    }
    
    override func layoutSubviews() {
        addGetures()
    }
    
    @IBAction func addText(sender: AnyObject) {
        var label = createLabelView()
        self.overlayViews.append(label)
        self.editAreaView.addSubview(label)
    }
    
    
    private func createLabelView() -> IQLabelView {
        let labelSide : CGFloat = 100
        let editAreaWidth = CGRectGetWidth(editAreaView.frame)
        let editAreaHeight = CGRectGetHeight(editAreaView.frame)
        
        let labelX = (editAreaWidth - labelSide) / 2
        let labelY = (editAreaHeight - labelSide) / 2
        
        var labelFrame = CGRect(x: labelX, y: labelY, width: labelSide, height: labelSide)
        var label = IQLabelView(frame: labelFrame)
        
        label.textView = createTextView();
        return label
    }
    
    private func createTextView() -> UITextField {
        let textSide : CGFloat = 100
        var textView = UITextField(frame: CGRect(x: 0, y: 0, width: textSide, height: textSide))
        textView.textColor = UIColor.whiteColor()
        textView.backgroundColor = UIColor.blueColor()
        return textView
    }
    
    func touchOutside(gesture : UITapGestureRecognizer) {
        for label in self.overlayViews {
            label.hideEditingHandles()
        }
    }
    
    private func addGetures() {
        self.editAreaView.userInteractionEnabled = true
        self.editAreaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "touchOutside:"))
    }
    
    private func cleanView() {
        for label in self.overlayViews {
            label.removeFromSuperview()
        }
        self.overlayViews.removeAll(keepCapacity: false)
    }
    
}
