import Foundation

func getBufferWriter(fileURL: URL) -> FileHandle? {
    let fileManager = FileManager.default
    
    if !fileManager.fileExists(atPath: fileURL.path) {
        fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
    }
    
    do {
        let fileHandle = try FileHandle(forWritingTo: fileURL)
        fileHandle.seekToEndOfFile()
        return fileHandle
    } catch {
        print("Error getting buffer writer: \(error.localizedDescription)")
        return nil
    }
}

if #available(OSX 10.12, *) {
    let bufferWriter = getBufferWriter(fileURL: URL(fileURLWithPath: "./float/swift.txt", isDirectory: false))!
    let a: UInt32 = 0b00000001_00000000_00000000_00000000  // 2^24
    let b: UInt32 = 0b00000010_00000000_00000000_00000000  // 2^25
    print("a = ", a)
    print("b = ", b)

    let startTime = Int64(Date().timeIntervalSince1970 * 1000)
    var n = 0
    
    for c in a...b {
        let stringToWrite = String(format: "c = %08d => %8.1f\n", c, Float(c))
        bufferWriter.write(stringToWrite.data(using: .utf8)!)
        bufferWriter.synchronizeFile()

        if (c-a)%1000==0 {
            n += 1
            print("\(c-a)/16777\n")
        }
    }
    
    let stopTime = Int64(Date().timeIntervalSince1970 * 1000)
    
    print((stopTime - startTime))
    bufferWriter.synchronizeFile()
    bufferWriter.closeFile()
}
