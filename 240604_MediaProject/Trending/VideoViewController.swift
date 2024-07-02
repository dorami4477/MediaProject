//
//  VideoViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 7/2/24.
//

import UIKit
import WebKit

final class VideoViewController: UIViewController {

    var link:String = ""
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    private func configureHierarchy(){
        view.addSubview(webView)
    }
    private func configureLayout(){
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureUI(){
        view.backgroundColor = .white
        let url = URL(string: "https://www.youtube.com/watch?v=\(link)")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    

}
