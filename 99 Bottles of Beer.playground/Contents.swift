import UIKit

let totalNumberOfBottles : Int = 99

func beerSong(totalBottles : Int) {
    for remainingBottles in (0...totalBottles).reversed() {
        var lyric = ""
        
        if remainingBottles > 2 {
            lyric += "\(remainingBottles) bottles of beer on the wall, \(remainingBottles) bottles of beer\n" + "Take one down and pass it around, \(remainingBottles-1) bottles of beer on the wall.\n"
        } else if remainingBottles == 2 {
            lyric += "\(remainingBottles) bottles of beer on the wall, \(remainingBottles) bottles of beer\n" + "Take one down and pass it around, \(remainingBottles-1) bottle of beer on the wall.\n"
        } else if remainingBottles == 1 {
            lyric += "\(remainingBottles) bottle of beer on the wall, \(remainingBottles) bottle of beer\n" + "Take one down and pass it around, no more bottles of beer on the wall.\n"
        } else {
            lyric += "No more bottles of beer on the wall, no more bottles of beer\n" + "Go to the store and buy some more, \(totalBottles) bottles of beer on the wall.\n"
        }
        
        print(lyric)
    }
}

beerSong(totalBottles: totalNumberOfBottles)
