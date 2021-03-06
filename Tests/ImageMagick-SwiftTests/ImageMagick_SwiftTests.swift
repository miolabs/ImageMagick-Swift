    import XCTest
    @testable import ImageMagick_Swift

    final class ImageMagick_SwiftTests: XCTestCase {
        
        func documentPath() -> String {
            return CommandLine.arguments.count < 2 ? "\(FileManager().currentDirectoryPath)" : CommandLine.arguments[1]
        }
        
        func testJPG_to_PNG(){
            
            let src_path = documentPath() + "/resources/image_1.jpg"
            let dst_path = documentPath() + "/results/image_1.png"
            
            let w = MagickWand()
            try? w.readImage(fromPath: src_path)
            try? w.writeImage(toPath: dst_path)
        }
        
        func testResizeImage(){
            
            let src_path = documentPath() + "/resources/image_1.jpg"
            let dst_path = documentPath() + "/results/image_2.png"
            
            let w = MagickWand()
            try? w.readImage(fromPath: src_path)            
            w.resize(columns: 120, rows: 120, filterType: .lanczosFilter)
            try? w.writeImage(toPath: dst_path)
        }
        
        func testReadImageFromData(){
            
            let src_path = documentPath() + "/resources/image_1.jpg"
            let dst_path = documentPath() + "/results/image_3.png"
            
            let data = try! Data(contentsOf: URL(fileURLWithPath: src_path))
            
            let w = MagickWand()
            try? w.readImage(fromData: data)
            try? w.writeImage(toPath: dst_path)
        }

        func testWriteImageFromData(){
            
            let src_path = documentPath() + "/resources/image_1.jpg"
            let dst_path = documentPath() + "/results/image_4.png"
            
            let w = MagickWand()
            try? w.readImage(fromPath: src_path)
            
            let data = try? w.imageData(format: "png")
            try? data?.write(to: URL(fileURLWithPath: dst_path))
        }
        
        func testCropImage(){
            let src_path = documentPath() + "/resources/image_1.jpg"
            let dst_path = documentPath() + "/results/image_5.png"
            
            let w = MagickWand()
            try? w.readImage(fromPath: src_path)
            
            w.crop(width: 120, height: 120, x: 10, y: 10)
            try? w.writeImage(toPath: dst_path)
        }


    }
