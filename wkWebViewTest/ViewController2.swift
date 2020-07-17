//
//  ViewController2.swift
//  wkWebViewTest
//
//  Created by 김민영 on 2020/07/17.
//  Copyright © 2020 MINYOUNGKIM. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ViewController2:UIViewController{
    
    var wv : WKWebView!
    
    override func loadView() {
        super.loadView()
        print("loadView() call")
        let webConfig = WKWebViewConfiguration()
        let userSrcipt = WKUserScript(source: "callTest()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let contentController = WKUserContentController()
        contentController.addUserScript(userSrcipt)
        webConfig.userContentController = contentController

        wv = WKWebView(frame: .zero, configuration: webConfig)
        
        self.view.addSubview(wv)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad() call")
        wv.de
        wv.load(URLRequest(url: URL(string:"http://127.0.0.1:8081/")!))
        
    }
    
    
}
