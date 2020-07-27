/**
 *  Copyright (C) 2010-2020 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import Nimble
import XCTest

@testable import Pocket_Code

class UploadViewControllerTests: XCTestCase {

    var uploadViewController: UploadViewController!
    var uploaderMock: StoreProjectUploaderMock!
    var delegateMock: UploadCategoryViewControllerDelegateMock!
    var uploadCategoryViewController: UploadCategoryViewController!
    var project: Project!

    override func setUp() {
        super.setUp()
        self.project = ProjectMock()
        self.project.header.programName = "testProjectName"

        self.uploaderMock = StoreProjectUploaderMock()
        self.uploadViewController = UploadViewController(uploader: uploaderMock, project: project)

        self.delegateMock = UploadCategoryViewControllerDelegateMock()
        self.uploadCategoryViewController = UploadCategoryViewController(delegate: delegateMock)
    }

    func testUploadAction() {
        XCTAssertEqual(0, uploaderMock.timesUploadMethodCalled)
        XCTAssertNil(uploaderMock.projectToUpload)

        uploadViewController.uploadAction()
        XCTAssertEqual(1, uploaderMock.timesUploadMethodCalled)
        XCTAssertEqual(project, uploaderMock.projectToUpload)
    }

    func testDelegate() {
        XCTAssertNil(delegateMock.tags)

        uploadCategoryViewController.sendBack(selectedCategories: ["testTag1", "testTag2"])

        XCTAssertNotNil(delegateMock.tags)
        XCTAssertEqual(delegateMock.tags?.count, 2)
        XCTAssertEqual(delegateMock.tags?[0], "testTag1")
        XCTAssertEqual(delegateMock.tags?[1], "testTag2")
    }
}
