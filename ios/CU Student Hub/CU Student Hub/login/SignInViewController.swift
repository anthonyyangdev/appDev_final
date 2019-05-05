import UIKit
import GoogleSignIn
import SnapKit

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    // MARK: - View vars
    var appNameLabel: UILabel!
    var signInButton: GIDSignInButton!
    var appLogo: UIImageView!
    
    // MARK: - Constants
    let verticalSpace: CGFloat = 125
    let appName = "CU Student Hub"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0xD8, green: 0xD8, blue: 0xD8, alpha: 1)
        GIDSignIn.sharedInstance().uiDelegate = self
        
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        signInButton = GIDSignInButton()
        signInButton.style = .wide
        signInButton.colorScheme = .dark
        view.addSubview(signInButton)
        
        appLogo = UIImageView()
        appLogo.image = UIImage(named: "logo")
        appLogo.clipsToBounds = true
        appLogo.contentMode = .scaleAspectFit
        view.addSubview(appLogo)
    }
    
    func setupConstraints() {
        appLogo.snp.makeConstraints { make in
        make.width.equalToSuperview().inset(100)
            make.bottom.equalTo(view.snp.centerY).offset(-verticalSpace / 2)
            make.centerX.equalToSuperview()
        }
//
//        appLogo.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview()
//            make.width.equalToSuperview().inset(100)
//
//        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).offset(verticalSpace / 2)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
