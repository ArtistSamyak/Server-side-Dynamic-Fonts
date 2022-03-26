//
//  ViewController.swift
//  Dynammic Fonts
//
//  Created by Samyak Pawar on 25/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayLabel.isHidden = true
        setCustomFont(of: 20)
        super.viewWillAppear(animated)
    }
    
    private func setCustomFont(of size: CGFloat) {
        URLSession.shared.dataTask(with: URL(string: "https://artistsamyak.github.io/CSS-MySite/CustomFont.json")!) { data, response, error in
            
            let decoder = JSONDecoder()
            let fontUrlString = try! decoder.decode(String.self, from: data!)
            print(fontUrlString)
            FileDownloader.loadFileAsync(url: URL(string: fontUrlString)!) { (path, error) in
                print("Font .ttf File downloaded to : \(path!)")
                let font = self.getFont(path: path!, size: size)
                DispatchQueue.main.async {
                    self.displayLabel.font = font
                    self.displayLabel.isHidden = false
                }
            }
            
        }.resume()
    }
    
    private func getFont(path: String, size: CGFloat) -> UIFont? {
        
        guard let fontFile = NSData(contentsOfFile: path)
        else {
            print("Font file not found?")
            return nil
        }

        guard let provider = CGDataProvider(data: fontFile)
        else {
            print("Failed to create DataProvider")
            return nil
        }

        let font = CGFont(provider)!
        let error: UnsafeMutablePointer<Unmanaged<CFError>?>? = nil

        guard CTFontManagerRegisterGraphicsFont(font, error) else {
            guard
                let unError = error?.pointee?.takeUnretainedValue(),
                let description = CFErrorCopyDescription(unError)
            else {
                print("Unknown error")
                return nil
            }
            print(description)
            
        }
        
        let fontName = String(font.fullName!)
        
        return UIFont(name: fontName, size: size)
    }
    

}

