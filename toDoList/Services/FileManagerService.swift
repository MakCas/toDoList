//
//  FileManagerService.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import UIKit

protocol FileManagerServiceProtocol {

    func saveFileAt(fileName: String, fileData: Data)
    func loadFileDataAt(fileName: String) -> Data?
}

final class FileManagerService {

    // MARK: - Properties

    static let shared: FileManagerServiceProtocol = FileManagerService()

    private var filesFolderName: String {
        let filesFolderName = "files"
        guard let cacheDirectoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return filesFolderName }
        let folderUrl = cacheDirectoryUrl.appendingPathComponent(filesFolderName)

        if !FileManager.default.fileExists(atPath: folderUrl.path) {
            do {
                try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                printDebug(error.localizedDescription)
            }
        }
        return filesFolderName
    }

    // MARK: - Init

    private init() {}

    // MARK: - Functions

    private func getFilePath(for fileName: String) -> String? {
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let filePath = cacheDirectory.appendingPathComponent(filesFolderName + fileName)
        return filePath.path
    }
}

// MARK: - FileManagerServiceProtocol

extension FileManagerService: FileManagerServiceProtocol {

    func saveFileAt(fileName: String, fileData: Data) {
        guard let fileUrl = getFilePath(for: fileName) else { return }
        FileManager.default.createFile(atPath: fileUrl, contents: fileData, attributes: nil)
    }

    func loadFileDataAt(fileName: String) -> Data? {
        guard let fileUrlString = getFilePath(for: fileName) else { return nil }
        let fileUrl = URL(fileURLWithPath: fileUrlString)
        do {
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch {
            return nil
        }
    }
}
