//
//  ViewController.swift
//  QExtensions
//
//  Created by Tomas Holicky on 26/09/2019.
//  Copyright © 2019 Qusion. All rights reserved.
//

import UIKit
import os.log

extension QBase {
    
    open class ViewController<ViewModelType>: UIViewController, ViewControllerStyleable {
        
        // MARK: View Model
        
        public var viewModel: ViewModelType!
        
        // MARK: Initializers
        
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public init(viewModel: ViewModelType) {
            super.init(nibName: nil, bundle: nil)
            
            if QBase.isLoggingEnabled {
                if #available(iOS 10.0, *) {
                    os_log("Initialized %@", log: Logger.lifecycleLog(), type: .info, self)
                } else {
                    NSLog("Initialized \(self)")
                }
            }
            
            defer {
                self.viewModel = viewModel
            }
        }
        
        deinit {
            if #available(iOS 10.0, *) {
                os_log("Deinitialized %@", log: Logger.lifecycleLog(), type: .info, self)
            } else {
                NSLog("Deinitialized \(self)")
            }
        }
        
        // MARK: Lifecycle
        
        override open func viewDidLoad() {
            super.viewDidLoad()
            
            if let navbarImage = self.backButtonImage() {
                navigationController?.navigationBar.backIndicatorImage = navbarImage
                navigationController?.navigationBar.backIndicatorTransitionMaskImage = navbarImage
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            }
            
            navigationItem.hidesBackButton = !self.canNavigateBack()
        }
        
        // MARK: - Navigation methods
        
        open func backButtonImage() -> UIImage? {
            return nil
        }
        
        open func canNavigateBack() -> Bool {
            return true
        }
        
        // MARK: Style
        
        open func setStyle() {}
    }
}


