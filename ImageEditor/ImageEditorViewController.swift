import UIKit

class ImageEditorViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editAreaView: UIView!
    @IBOutlet weak var editToolbar: UIView!
    
    var currentTool : EditorTextTool?
    var editMode : Bool
    
    required init(coder aDecoder: NSCoder) {
        self.editMode = false
        super.init(coder: aDecoder)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func showTextTool(sender: AnyObject) {
        self.currentTool = EditorTextTool()
        let selfFrame = self.view.frame
        let toolFrame = CGRect(x: CGRectGetMinX(selfFrame), y: CGRectGetMaxY(editToolbar.frame), width: CGRectGetWidth(selfFrame), height: CGRectGetHeight(selfFrame) - CGRectGetHeight(editToolbar.frame))
        self.currentTool?.getView().frame = toolFrame
        self.view.addSubview(self.currentTool!.getView())
        setEditMode(true)
    }
    
    @IBAction func showStickerTool(sender: AnyObject) {
    }
    
    @IBAction func editCancel(sender: AnyObject) {
        dismissTool()
        setEditMode(false)
    }
    
    @IBAction func editApply(sender: AnyObject) {
        dismissTool()
        setEditMode(false)
    }
    
    private func setEditMode(editMode : Bool) {
        self.editMode = editMode
        if editMode {
            editToolbar.hidden = false
        } else {
            editToolbar.hidden = true
        }
    }
    
    private func dismissTool() {
        self.currentTool?.dismiss()
    }
}

