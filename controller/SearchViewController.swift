//
//  SearchViewController.swift
//  food
//
//  Created by Raghava on 10/04/21.
//  Copyright © 2021 Raghava. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class SearchViewController: UIViewController {
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var foodNam: UILabel!
    @IBOutlet weak var foodCatag: UILabel!
    @IBOutlet weak var foodIm: UIImageView!
    @IBOutlet weak var foodInstru: UILabel!
    @IBOutlet var videoPlayer:YTPlayerView!
    var imageData:Data!

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    @IBAction func searchButton(_ sender: Any) {
        guard let search : String = searchText.text! else{print("text field is empty")}
        var url = "https://www.themealdb.com/api/json/v1/1/search.php?s="
        url += search
        print(url)
        var meal:[[String : Any]]!
            var URLReqObj = URLRequest(url:URL(string:url)!)
            let dataTaskObj = URLSession.shared.dataTask(with: URLReqObj) { (data, response, error) in
                do{
                    print("started serialzing")
                    let output = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as![String:Any]
                    let temp = output["meals"]
                    meal = temp as? [[String : Any]]
                    print(meal)
                }
                catch
                {
                 print("data has not found")
                }
            }
            dataTaskObj.resume()
            while meal == nil
            {}
            print("returned value")
      var imageURL = meal[0]["strMealThumb"]! as! String
        imageURL = imageURL.replacingOccurrences(of: "", with: "%20")
        print("URL:",imageURL)
        do{imageData = try Data(contentsOf: URL(string: imageURL)!)
         foodIm.image = UIImage(data: imageData)}
         catch{print("failed to fetch image")}
             var tempImage = UIImage(data: imageData)
             var foodName = meal[0]["strMeal"] as! String
             var foodcat = meal[0]["strCategory"] as! String
             var foodInt = meal[0]["strInstructions"] as! String
             var foodVideo = meal[0]["strYoutube"] as! String
             foodNam.text! += foodName
             foodCatag.text! += foodcat
             foodInstru.text! += foodInt
        let range = foodVideo.index(foodVideo.startIndex,offsetBy: 32)..<foodVideo.endIndex
        print(foodVideo[range])
        print(foodVideo)
        let foodVideoLink = foodVideo[range]
        videoPlayer.load(withVideoId: "\(foodVideoLink)")    }
}
