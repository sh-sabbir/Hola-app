//
//  HolaApp.swift
//  Hola
//
//  Created by Sabbir Hasan on 27/2/24.
//

import SwiftUI
import SwiftData
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var app: HolaApp?

    func applicationWillTerminate(_ notification: Notification) {
        app?.stopHolaServer()
    }
}

@main
struct HolaApp: App {
    // MARK: - Properties
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var processInfo: String = "No process found on port 1525"
    @State var isHolaRunning = false
    
    var task = Process()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // MARK: - Initializers
    init() {
        let appDelegate = AppDelegate()
        appDelegate.app = self
        if NSApp == nil {
            NSApplication.shared.delegate = appDelegate
        } else {
            NSApp.delegate = appDelegate
        }
    }
    
    // MARK: - Scene
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .frame(minWidth: 1376, idealWidth: 1376, maxWidth: .infinity, minHeight: 740, idealHeight: 740, maxHeight: .infinity, alignment: .leading)
                .onAppear(perform: {
                    createDbFile()
                    checkProcessOnPort(port:1525)
                    startHolaServer()
                })
        }
        .modelContainer(sharedModelContainer)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
    
    // MARK: - File Management
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask) //or .libraryDirectory
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func createDbFile() {
        let bundleIdentifier =  Bundle.main.bundleIdentifier
        let dbName = "hola.db"
        let dbPath = getDocumentsDirectory().appendingPathComponent(bundleIdentifier!)
        let dbUrl = dbPath.appendingPathComponent(dbName)
        
        if let bundlePath = Bundle.main.path(forResource: "hola", ofType: "db") {
            print("File exists at path: \(bundlePath)")
        } else {
            print("File does not exist in the app bundle.")
        }
        
        // Check if the destination directory exists
        if !FileManager.default.fileExists(atPath: dbPath.path) {
            do {
                try FileManager.default.createDirectory(at: dbPath, withIntermediateDirectories: true, attributes: nil)
                print("Destination directory created: \(dbPath.path)")
            } catch {
                print("Error creating destination directory: \(error)")
                fatalError(error.localizedDescription)
            }
        }
        
        if !FileManager.default.fileExists(atPath: dbUrl.path) {
            do {
                try FileManager.default.copyItem(at: Bundle.main.url(forResource: "hola", withExtension: "db")!, to: dbUrl)
            } catch {
                print(error)
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Server Management
    func startHolaServer() {
        let bundle = Bundle.main
        let execURL = bundle.url(forResource: "hola-darwin-arm64", withExtension: nil)
        guard execURL != nil else {
            print("Hola executable could not be found!")
            return
        }
        self.task.executableURL = execURL!
        self.task.arguments = ["--verbose","--smtp-auth-allow-insecure", "--smtp-auth-accept-any", "--db-file", "/Users/sabbirhasan/Library/dev.iamsabbir.Hola/hola.db"]
        
        do {
            try self.task.run()
            isHolaRunning = true
            print("Hola started successfully!")
        } catch {
            print("Error running Hola: \(error)")
        }
    }
    
    func stopHolaServer() {
        // Terminate the server process if it's running
        checkProcessOnPort(port:1525)
        isHolaRunning = false
        print("Hola terminated")
    }
    
    func checkProcessOnPort(port: Int32) {
        do {
            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/usr/sbin/lsof")
            task.arguments = ["-i", "tcp:\(port)"] // Include only listening sockets
            
            let pipe = Pipe()
            task.standardOutput = pipe
            
            try task.run()
            task.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                print(output)
                let lines = output.components(separatedBy: "\n")
                
                if lines.count > 1 {
                    var processIDs = [String]()
                    for i in 1..<lines.count {
                        let processItem = lines[i].components(separatedBy: " ")
                        if processItem.count >= 2 {
                            processIDs.append(processItem[1])
                        }
                    }
                    
                    for id in processIDs {
                        stopProcessWithPID(pidToStop: id)
                    }
                    print(processIDs)
                } else {
                    print("No process found on port \(port)")
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func stopProcessWithPID(pidToStop: String) {
        do {
            let pid = Int32(pidToStop) ?? 0
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/bin/kill")
            process.arguments = ["-9", "\(pid)"] // Sending SIGKILL signal to terminate process
            
            let pipe = Pipe()
            process.standardOutput = pipe
            
            try process.run()
            process.waitUntilExit()
            
            print("Process with PID \(pid) has been stopped")
        } catch {
            print("Error stopping process: \(error.localizedDescription)")
        }
    }
}
