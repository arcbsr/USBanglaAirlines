//
//  LaunchAnimationViewController.swift
//  Football(2020-21)
//
//  Created by Shahed Mamun on 14/4/21.
//

import UIKit
import Alamofire
import SVProgressHUD
import AlamofireObjectMapper


class LaunchAnimationViewController: UIViewController {
    //    private let imageView: UIImageView = {
    //        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    //        imageView.image = UIImage(named: "fo_icon")
    //        imageView.contentMode = .scaleAspectFit
    //        return imageView
    //    }()
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!{
        didSet{
            activityIndicatorView.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        //
        //            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController(){
        //                let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //                let window = appDelegate?.window
        //                window?.rootViewController = vc
        //                window?.makeKeyAndVisible()
        //            }
        //        }
        
        fetchOfferPlaces()
    }
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //
    //        imageView.center = view.center
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    //            self.animate()
    //        }
    //    }
    //
    //    func animate(){
    //        UIView.animate(withDuration: 1) {
    //            let size = self.view.frame.size.width * 3
    //            let diffX = size - self.view.frame.size.width
    //            let diffY = self.view.frame.size.height - size
    //            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
    //        }
    //        UIView.animate(withDuration: 1.5, animations: {
    //            self.imageView.alpha = 0
    //        }, completion: { (success) in
    //            if success{
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    //
    //                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController(){
    //                        let appDelegate = UIApplication.shared.delegate as? AppDelegate
    //                        let window = appDelegate?.window
    //                        window?.rootViewController = vc
    //                        window?.makeKeyAndVisible()
    //                    }
    //                }
    //            }
    //        })
    //    }
    
}


// MARK: API CALL
extension LaunchAnimationViewController{
    
    func fetchOfferPlaces() {
        
        //            let headers: HTTPHeaders = [
        //                "Authorization": "token \(UserInfo.token)"
        //            ]
        
        //        let requestInfo: Parameters = [
        //            "AuthenticationKey": "_JEAAAAL436mpPsYP3m2lwfwBiLPdzcUQEHyecX5mtHR1RMK0DTHTEiyA_EYVUazFkn3rIGIGu6wxA8qa1gYyfs1uOib4E_U",
        //            "CultureName": "en-GB"
        //        ]
        //
        //        let request: Parameters = [
        //            "RequestInfo": requestInfo,
        //            "ValueCodeName": "Airport"
        //        ]
        //
        //        let params: Parameters = [
        //            "request": request
        //        ]
        
        guard let url = URL(string: "https://usbair.com/app2/LoadHomePageSpecialOfferImage.json") else{
            return
        }
        
        print("offer url:\(url)")
        //        SVProgressHUD.show()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<OfferPlaceModel>) in
            if SVProgressHUD.isVisible(){
                SVProgressHUD.dismiss()
            }
//             if GlobalItems.isTestBuild{
//                print("=== response = \(response)")
//            }
            //            guard let statusCode = response.response?.statusCode else{
            //                return
            //            }
            print("statusCode = \( String(describing: response.response?.statusCode))")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let navVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController, let vc = navVC.children.first as? HomeViewController{
                    vc.offerplaces = response.result.value?.item?.offerplace ?? [Offerplace]()
                    vc.home = response.result.value?.item?.home
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    let window = appDelegate?.window
                    window?.rootViewController = navVC
                    window?.makeKeyAndVisible()
                }
            }
            
            //            switch response.result {
            //            case .success:
            //                self.offerplaces = response.result.value?.item?.offerplace ?? [Offerplace]()
            //                self.offerCollectionView.reloadData()
            //            case .failure(let error):
            //                print("error = \(error)")
            //            }
            
        })
        .responseJSON { (json) in
//            print("json = \(json)")
        }
    }
    
}
