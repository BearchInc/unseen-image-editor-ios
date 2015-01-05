import Foundation

protocol EditorToolProtocol {
    func getView() -> UIView
    func getImage() -> UIImage
    func getName() -> NSString
    func dismiss()
}

