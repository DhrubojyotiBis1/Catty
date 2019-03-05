/**
 *  Copyright (C) 2010-2019 The Catrobat Team
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

import Foundation

class Note: NSObject {
    var noteDurationTimer: Timer
    var pitch: Int
    var beats: Double
    var bpm: Double
    var pauseDate: Date?
    var previousFireDate: Date?

    init(pitch: Int, beats: Double, bpm: Double, noteDurationTimer: Timer) {
        self.noteDurationTimer = noteDurationTimer
        self.pitch = pitch
        self.beats = beats
        self.bpm = bpm
    }

    func setActive() {
        let durationInSeconds = beats * 60 / bpm
        noteDurationTimer.fireDate = Date(timeInterval: durationInSeconds, since: Date())
        let mainRunLoop = RunLoop.main
        mainRunLoop.add(noteDurationTimer, forMode: RunLoop.Mode.default)
    }

    func pause() {
        previousFireDate = noteDurationTimer.fireDate
        pauseDate = Date()
        noteDurationTimer.fireDate = Date.distantFuture
    }

    func resume() {
        if let pauseDate = pauseDate, let previousFireDate = previousFireDate {
            let pauseTime = -pauseDate.timeIntervalSinceNow
            noteDurationTimer.fireDate = Date(timeInterval: pauseTime, since: previousFireDate)
        } else {
            noteDurationTimer.fire()
        }
    }
}
