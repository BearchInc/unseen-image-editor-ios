import Foundation

class EditorTextTool : EditorToolProtocol {
    
    var textToolView : TextToolView
    var sourceImage : UIImage
    
    init(sourceImage : UIImage) {
        self.textToolView = NSBundle.mainBundle().loadNibNamed("TextToolView", owner: nil, options: nil)[0] as TextToolView
        self.sourceImage = sourceImage
    }
    
    func getView() -> UIView {
        return textToolView
    }
    
    func getImage() -> UIImage {
        var imageCreator = ImageCreator()
        return imageCreator.addLabelToImage(self.sourceImage, labels: self.textToolView.overlayViews, container: self.textToolView.editAreaView)
    }
    
    func getName() -> NSString {
        return "Text"
    }
    
    func dismiss() {
        self.textToolView.removeFromSuperview()
    }
    
}