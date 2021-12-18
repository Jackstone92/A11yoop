//
//  A11yoopMonitorIntegrationTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import CombineSchedulers
@testable import A11yoopMonitor
import A11yFeature
import A11yStatusEmitter
import A11yStatusObserver
@testable import A11yStatusObserverLive
import A11yStatusProvider

final class A11yoopMonitorIntegrationTests: XCTestCase {

    private var sut: A11yoopMonitor!

    private var statusChangeSubject: CurrentValueSubject<[A11yStatus], Never>!
    private var notificationCenter: NotificationCenter!

    /// An initial query is made to the status provider when `A11yoopMonitor` is instantiated
    private let initialisationStatusQueryResults: [A11yStatus] = [.disabled]

    /// Describes subsequent status changes to be observed.
    private let statusChanges: [A11yStatus] = [.disabled, .enabled, .disabled]

    override func setUp() {
        super.setUp()
        notificationCenter = NotificationCenter()
        statusChangeSubject = CurrentValueSubject<[A11yStatus], Never>(initialisationStatusQueryResults + statusChanges)
    }

    // MARK: - Default value tests
    func test_defaultVoiceOverStatus() throws {

        try assertDefaultStatus(for: .voiceOver, is: .disabled)
    }

    func test_defaultBoldTextStatus() throws {

        try assertDefaultStatus(for: .boldText, is: .disabled)
    }

    func test_defaultLargerTextStatus() throws {

        try assertDefaultStatus(for: .largerText, is: .contentSize(.large))
    }

    func test_defaultSwitchControlStatus() throws {

        try assertDefaultStatus(for: .switchControl, is: .disabled)
    }

    func test_defaultGreyScaleStatus() throws {

        try assertDefaultStatus(for: .greyscale, is: .disabled)
    }

    func test_defaultInvertColoursStatus() throws {

        try assertDefaultStatus(for: .invertColours, is: .disabled)
    }

    func test_defaultOnOffLabelsStatus() throws {

        try assertDefaultStatus(for: .onOffLabels, is: .disabled)
    }

    func test_defaultReduceTransparencyStatus() throws {

        try assertDefaultStatus(for: .reduceTransparency, is: .disabled)
    }

    func test_defaultReduceMotionStatus() throws {

        try assertDefaultStatus(for: .reduceMotion, is: .disabled)
    }

    func test_defaultDifferentiateWithoutColourStatus() throws {

        try assertDefaultStatus(for: .differentiateWithoutColour, is: .disabled)
    }

    func test_defaultAssistiveTouchStatus() throws {

        try assertDefaultStatus(for: .assistiveTouch, is: .disabled)
    }

    func test_defaultShakeToUndoStatus() throws {

        try assertDefaultStatus(for: .shakeToUndo, is: .enabled)
    }

    func test_defaultDarkerSystemColoursStatus() throws {

        try assertDefaultStatus(for: .darkerSystemColours, is: .disabled)
    }

    @available(iOS 14, *)
    func test_defaultButtonShapesStatus() throws {

        try assertDefaultStatus(for: .buttonShapes, is: .disabled)
    }

    func test_defaultSpeakScreenStatus() throws {

        try assertDefaultStatus(for: .speakScreen, is: .disabled)
    }

    func test_defaultSpeakSelectionStatus() throws {

        try assertDefaultStatus(for: .speakSelection, is: .disabled)
    }

    func test_defaultHearingDevicePairedEarStatus() throws {

        try assertDefaultStatus(for: .hearingDevicePairedEar, is: .disabled)
    }

    func test_defaultGuidedAccessStatus() throws {

        try assertDefaultStatus(for: .guidedAccess, is: .disabled)
    }

    @available(iOS 14, *)
    func test_defaultPreferCrossFadeTransitionsStatus() throws {

        try assertDefaultStatus(for: .preferCrossFadeTransitions, is: .disabled)
    }

    private func assertDefaultStatus(for featureType: A11yFeatureType, is expectedStatus: A11yStatus) throws {

        sut = A11yoopMonitor(queue: .immediate)

        let status = try XCTUnwrap(sut.allFeatures.first { $0.type == featureType }?.status)

        XCTAssertEqual(status, expectedStatus)
    }

    // MARK: - Monitor tests
    func test_canMonitorVoiceOverStatusChanges() {

        assertCanMonitor(featureType: .voiceOver)
    }

    func test_canMonitorBoldTextStatusChanges() {

        assertCanMonitor(featureType: .boldText)
    }

    func test_canMonitorLargerTextStatusChanges() {

        assertCanMonitor(featureType: .largerText) // TODO:
    }

    func test_canMonitorSwitchControlStatusChanges() {

        assertCanMonitor(featureType: .switchControl)
    }

    func test_canMonitorGreyScaleStatusChanges() {

        assertCanMonitor(featureType: .greyscale)
    }

    func test_canMonitorInvertColoursStatusChanges() {

        assertCanMonitor(featureType: .invertColours)
    }

    func test_canMonitorOnOffLabelsStatusChanges() {

        assertCanMonitor(featureType: .onOffLabels)
    }

    func test_canMonitorReduceTransparencyStatusChanges() {

        assertCanMonitor(featureType: .reduceTransparency)
    }

    func test_canMonitorReduceMotionStatusChanges() {

        assertCanMonitor(featureType: .reduceMotion)
    }

    func test_canMonitorDifferentiateWithoutColourStatusChanges() {

        assertCanMonitor(featureType: .differentiateWithoutColour)
    }

    func test_canMonitorAssistiveTouchStatusChanges() {

        assertCanMonitor(featureType: .assistiveTouch)
    }

    func test_canMonitorShakeToUndoStatusChanges() {

        assertCanMonitor(featureType: .shakeToUndo)
    }

    func test_canMonitorDarkerSystemColoursStatusChanges() {

        assertCanMonitor(featureType: .darkerSystemColours)
    }

    @available(iOS 14, *)
    func test_canMonitorButtonShapesStatusChanges() {

        assertCanMonitor(featureType: .buttonShapes)
    }

    func test_canMonitorSpeakScreenStatusChanges() {

        assertCanMonitor(featureType: .speakScreen)
    }

    func test_canMonitorSpeakSelectionStatusChanges() {

        assertCanMonitor(featureType: .speakSelection)
    }

    func test_canMonitorHearingDevicePairedEarStatusChanges() {

        assertCanMonitor(featureType: .hearingDevicePairedEar)
    }

    func test_canMonitorGuidedAccessStatusChanges() {

        assertCanMonitor(featureType: .guidedAccess)
    }

    @available(iOS 14, *)
    func test_canMonitorPreferCrossFadeTransitionsStatusChanges() {

        assertCanMonitor(featureType: .preferCrossFadeTransitions)
    }

    // MARK: - Test helpers
    private func assertCanMonitor(featureType: A11yFeatureType) {

        var emittedFeatureChanges = [A11yFeature]()

        let spy = A11yStatusEmitter { emittedFeatureChanges.append($0) }
        let provider = A11yStatusProvider { Self.handleGetStatus(for: $0, statusChangeSubject: self.statusChangeSubject) }

        sut = A11yoopMonitor(
            monitor: .live(
                featureTypes: [featureType],
                emitters: [spy],
                statusObserver: .live(
                    featureStore: .live,
                    statusProvider: provider,
                    notificationCenter: notificationCenter,
                    queue: .immediate
                ),
                statusProvider: provider
            )
        )

        (0..<statusChanges.count).forEach { _ in notificationCenter.post(name: featureType.notificationName, object: nil) }

        XCTAssertTrue(statusChangeSubject.value.isEmpty)
        XCTAssertEqual(
            emittedFeatureChanges,
            [
                A11yFeature(type: featureType, status: .disabled),
                A11yFeature(type: featureType, status: .enabled),
                A11yFeature(type: featureType, status: .disabled)
            ]
        )
    }

    private static func handleGetStatus(
        for featureType: A11yFeatureType,
        statusChangeSubject: CurrentValueSubject<[A11yStatus], Never>
    ) -> A11yStatus {
        guard case featureType = featureType else {
            XCTFail("Unexpected featureType")
            return .notSupported
        }

        guard !statusChangeSubject.value.isEmpty else {
            XCTFail("statusChangeSubject should not be empty")
            return .notSupported
        }

        var remainingStatuses = statusChangeSubject.value
        let statusToReturn = remainingStatuses.removeFirst()

        statusChangeSubject.send(remainingStatuses)

        return statusToReturn
    }
}
