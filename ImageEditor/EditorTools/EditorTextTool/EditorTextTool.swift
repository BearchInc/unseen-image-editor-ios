import Foundation

class EditorTextTool : EditorToolProtocol {
    
    var textToolView : TextToolView
    
    init() {
        textToolView = NSBundle.mainBundle().loadNibNamed("TextToolView", owner: nil, options: nil)[0] as TextToolView
    }
    
    func getView() -> UIView {
        return textToolView
    }
    
    func getImage() -> UIImage {
        return UIImage()
    }
    
    func getName() -> NSString {
        return "Text"
    }
    
    func dismiss() {
        self.textToolView.removeFromSuperview()
    }
    
}