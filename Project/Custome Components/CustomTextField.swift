//
//  CustomTextField.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import UIKit

@IBDesignable
public class CustomTextField: UIView {
    private let innerColor = UIColor(red: 209/255, green: 232/255, blue: 179/255, alpha: 0.46)
    private let greenColor: UIColor = .purple
    private let grayColor: UIColor = .gray
    private let redColor: UIColor = .red
    let textField: UITextField = {
        let textField = UITextField()
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 1))
        textField.rightViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 1))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(checkForSelection), for: .editingChanged)
        return textField
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 12)
        label.alpha = 0
        label.text = " "
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        return label
    }()
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.text = " "
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        return label
    }()
    @IBInspectable public var currentColor: UIColor = UIColor.clear {
        didSet { textField.backgroundColor = currentColor }
    }
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet { textField.layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet { textField.layer.borderWidth = borderWidth }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet { textField.layer.cornerRadius = cornerRadius }
    }
    @IBInspectable public var text: String {
        get { textField.text ?? "" }
        set { textField.text = newValue }
    }
    @IBInspectable public var placeholder: String {
        get { textField.placeholder ?? "" }
        set { textField.placeholder = newValue; titleLabel.text = newValue; }
    }
    @IBInspectable public var fontSize: CGFloat {
        get { textField.font?.pointSize ?? 0 }
        set { textField.font = textField.font?.withSize(newValue) }
    }
    @IBInspectable public var rightImage: UIImage? = nil {
        didSet {
            let rightViewHeight = (frame.height - titleLabel.frame.height - 5) * 0.5
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightViewHeight + 20, height: rightViewHeight))
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: rightViewHeight, height: rightViewHeight))
            rightView.addSubview(imageView)
            imageView.image = rightImage
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
    }
    @IBInspectable public var secureEntry: Bool = false {
        didSet { if secureEntry { textField.isSecureTextEntry = secureEntry }}
    }
    @IBInspectable public var isPhone: Bool = false {
        didSet { if isPhone { textField.keyboardType = .phonePad } }
    }
    @IBInspectable public var showTitleLabel: Bool = true
    var delegate: UITextFieldDelegate? = nil {
        didSet { textField.delegate = delegate }
    }
    var field: UITextField {
        get { return textField }
    }
    override public func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        backgroundColor = .clear
        addSubview(textField)
        addSubview(titleLabel)
        addSubview(errorLabel)
        textField.setValue(UIColor.darkGray, forKeyPath: "placeholderLabel.textColor")
        titleLabel.textColor = greenColor
        errorLabel.textColor = redColor
        NSLayoutConstraint.activate([textField.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     textField.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                                     textField.bottomAnchor.constraint(equalTo: errorLabel.topAnchor, constant: -5),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                     titleLabel.topAnchor.constraint(equalTo: topAnchor),
                                     errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                                     errorLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                                     errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
        self.titleLabel.frame.origin.y = 10
    }
    override public func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    @objc
    private func checkForSelection() {
        if text.isEmpty {
            currentColor = .clear
            borderColor = grayColor
            showHideTitle(alpha: 0, yPosition: 10)
        } else {
            errorLabel.text = ""
            currentColor = innerColor
            borderColor = greenColor
            titleLabel.textColor = greenColor
            showHideTitle(alpha: 1, yPosition: 0)
        }
    }
    private func showHideTitle(alpha: CGFloat, yPosition: CGFloat) {
        if !showTitleLabel { return }
        UIView.animate(withDuration: 0.5) {
            self.titleLabel.alpha = alpha
            self.titleLabel.frame.origin.y = yPosition
        }
    }
    func setError(errorMessage: String = "") {
        errorLabel.text = errorMessage
        showHideTitle(alpha: 1, yPosition: 0)
        currentColor = redColor.withAlphaComponent(0.1)
        borderColor = redColor
        titleLabel.textColor = redColor
    }
    func isError() -> Bool {
        if titleLabel.textColor == redColor {
            return true
        }
        return false
    }
    func isEmpty() -> Bool {
        return text.isEmpty
    }
}
