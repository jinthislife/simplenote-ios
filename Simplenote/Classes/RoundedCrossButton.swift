import UIKit

// MARK: RoundedCrossButton
//
class RoundedCrossButton: UIButton {

    override var frame: CGRect {
        didSet {
            guard frame.size != oldValue.size else {
                return
            }

            updateCornerRadius()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    deinit {
        stopListeningToNotifications()
    }
}

// MARK: - Private
//
private extension RoundedCrossButton {
    func configure() {
        startListeningToNotifications()

        layer.masksToBounds = true
        updateCornerRadius()
        refreshStyle()
    }

    func updateCornerRadius() {
        layer.cornerRadius = min(frame.height, frame.width) / 2
    }

    func refreshStyle() {
        setImage(UIImage.image(name: .cross)?.withRenderingMode(.alwaysTemplate), for: .normal)

        setBackgroundImage(UIColor.simplenoteCardDismissButtonBackgroundColor.dynamicImageRepresentation(), for: .normal)
        setBackgroundImage(UIColor.simplenoteCardDismissButtonHighlightedBackgroundColor.dynamicImageRepresentation(), for: .highlighted)

        tintColor = .simplenoteCardDismissButtonTintColor
    }
}

// MARK: - Notifications
//
private extension RoundedCrossButton {
    func startListeningToNotifications() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(themeDidChange), name: .SPSimplenoteThemeChanged, object: nil)
    }

    func stopListeningToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func themeDidChange() {
        refreshStyle()
    }
}
