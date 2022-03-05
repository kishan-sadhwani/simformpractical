//
//  Utility.swift
//  Template
//
//  Created by itechnotion on 23/11/21.
//

import UIKit
import SDWebImage
import MaterialComponents

class Utility: NSObject {
    
    static var spinner: UIActivityIndicatorView!
    
    static func addShadow(view : UIView, offset: CGSize, shadowColor: UIColor, radius: CGFloat, opacity: Float, mask: Bool? = false) {
        view.layer.masksToBounds = mask ?? false
        view.layer.shadowOffset = offset
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowRadius = 1.0
        view.layer.cornerRadius = radius
        view.layer.shadowOpacity = opacity
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        //        guard password != nil else { return false }
        
        // at least one uppercase
        // at least one digit
        // at least one lowercase
        // 8 characters total
        //"(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        //        Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    static func isValidPhone(_ value: String) -> Bool {
        let PHONE_REGEX = "^[6-9][0-9]{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    static func isValidMeetingCode(_ value: String) -> Bool {
        if value.count != 9 {
            return false
        }
        let CODE_REGEX = "^[0-9]{9}$"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", CODE_REGEX)
        let result =  codeTest.evaluate(with: value)
        return result
    }
    
    static func startSpinner(presenter: UIView) {
        if spinner == nil {
            spinner = UIActivityIndicatorView()
            spinner.hidesWhenStopped = true
            spinner.style = .whiteLarge
            spinner.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
            spinner.center = presenter.center
            spinner.frame = presenter.bounds
        }
        presenter.addSubview(spinner)
        spinner.startAnimating()
    }
    
    static func stopSpinner() {
        if spinner != nil {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
        }
    }
    
    static func showAlert(vc: UIViewController?, title: String, msg: String, btnPrimary: String, handler: ((UIAlertAction) -> Void)?) {
        let presenter = vc ?? UIApplication.shared.keyWindow?.rootViewController
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnPrimary, style: UIAlertAction.Style.default, handler: handler))
        presenter?.present(alert, animated: true)
    }
    
    static func showConfirmationAlert(vc: UIViewController?, title: String, msg: String, btnPrimary: String,btnCancel: String, positiveHandler: ((UIAlertAction) -> Void)?, negativeHandler: ((UIAlertAction) -> Void)?) {
        
        let presenter = vc ?? UIApplication.shared.keyWindow?.rootViewController
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnPrimary, style: UIAlertAction.Style.default, handler: positiveHandler))
        alert.addAction(UIAlertAction(title: btnCancel, style: UIAlertAction.Style.default, handler: negativeHandler))
        presenter?.present(alert, animated: true)
    }
    
    static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    static func addMarchingAnts(view: UIView) {
        let layer = CAShapeLayer()
        let bounds = CGRect(x: 50, y: 50, width: 250, height: 250)
        layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = nil
        layer.lineDashPattern = [8, 6]
        view.layer.addSublayer(layer)
    }
    
    static func flipViews(v1: UIView, v2: UIView) {
        UIView.transition(from: v1, to: v2, duration: 0.2,
                          options: [.transitionFlipFromRight, .showHideTransitionViews])
        { _ in
            v1.isUserInteractionEnabled = false
            v2.isUserInteractionEnabled = true
        }
    }
    
    static func heightForView(text:String, font:UIFont, lines: Int = 0, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0,y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = lines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    ///Call this method only once from your View Controller to support dismissing keyboard on tapping outside text related components.
    static func dismissKeyboardOnTap(view: UIView) {
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    static func convertDateStringFormat(ofDate dateStr: String, from fromFormat: String, to toFormat: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = toFormat
            return formatter.string(from: date)
        }
        return dateStr
    }
    
    static func convertDateStringFormatWithOutTimeZone(ofDate dateStr: String, from fromFormat: String, to toFormat: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = toFormat
            return formatter.string(from: date)
        }
        return dateStr
    }
    
    static func convertDateFormat(ofDate date: Date, to toFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = toFormat
        let dateStr = formatter.string(from: date)
        let newDate = formatter.date(from: dateStr)
        return newDate
    }
    
    static func getDate(inFormat format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    static func getDate(fromString date: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter.date(from: date)
    }
    
    static func removeExtension(fromName fileName: String) -> String{
        var components = fileName.components(separatedBy: ".")
        if components.count > 1 { // If there is a file extension
            components.removeLast()
            return components.joined(separator: ".")
        } else {
            return fileName
        }
    }
    
    func randomColor() -> UIColor {
        let random = {CGFloat(arc4random_uniform(255)) / 255.0}
        return UIColor(red: random(), green: random(), blue: random(), alpha: 1)
    }
    
    static func setImageWithPlaceholder(imageView: UIImageView, image imgStr: String, placeholderImageView: UIImage, tintColor : UIColor){
        //Load with decode
        let indicator = SDWebImageActivityIndicator.grayLarge
        indicator.indicatorView.color = UIColor.white
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.tintColor = tintColor
        imageView.sd_setImage(with: URL(string: imgStr), placeholderImage: #imageLiteral(resourceName: "profile"), options: [.scaleDownLargeImages, .decodeFirstFrameOnly])
    }
    
    static func setImage(imageView: UIImageView, image imgStr: String, placeholder: UIImage) {
        //Load with Kingfisher
        //        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        //        imageView.kf.setImage(with: URL(string: imgStr), placeholder: #imageLiteral(resourceName: "icon_placeholder"), options: [
        //            .processor(processor),
        //            .scaleFactor(UIScreen.main.scale),
        //            .transition(.fade(1))
        //        ])
        
        //        //Load without decode
        //        imageView.sd_setImage(with: URL(string: imgStr), placeholderImage: #imageLiteral(resourceName: "icon_placeholder"), options: [.scaleDownLargeImages, .avoidDecodeImage])
        
        //Load with decode
        let indicator = SDWebImageActivityIndicator.grayLarge
        indicator.indicatorView.color = UIColor.white
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: URL(string: imgStr), placeholderImage: placeholder, options: [.scaleDownLargeImages, .decodeFirstFrameOnly])
    }
    
//    static func isUpdateAvailable(callback: @escaping (Bool)->Void) {
//        let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
//        AF.request("https://itunes.apple.com/lookup?bundleId=\(bundleId)").responseJSON { response in
//            if let json = response.value as? NSDictionary, let results = json["results"] as? NSArray, let entry = results.firstObject as? NSDictionary, let versionStore = entry["version"] as? String, let versionLocal = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
//                let arrayStore = versionStore.split(separator: ".")
//                let arrayLocal = versionLocal.split(separator: ".")
//
//                if arrayLocal.count != arrayStore.count {
//                    callback(true) // different versioning system
//                }
//
//                // check each segment of the version
//                for (key, value) in arrayLocal.enumerated() {
//                    if Int(value)! < Int(arrayStore[key])! {
//                        callback(true)
//                    }
//                }
//            }
//            callback(false) // no new version or failed to fetch app store version
//        }
//    }
    
    static func showSnackbar(message: String, button: String = "", actionHandler: MDCSnackbarMessageActionHandler? = nil) {
        let message = MDCSnackbarMessage(text: message)
        if button != "" && actionHandler != nil
        {
            let action = MDCSnackbarMessageAction()
            action.handler = actionHandler
            action.title = button
            message.action = action
            message.duration = 10
        }
        MDCSnackbarManager.default.show(message)
    }
}
