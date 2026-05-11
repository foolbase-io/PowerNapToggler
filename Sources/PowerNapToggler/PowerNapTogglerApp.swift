//
//  PowerNapTogglerApp.swift
//  PowerNapToggler
//
//  Created by Alon on 19/06/2025.
//

import AppKit
import SwiftUI

enum PowerSettingState: Equatable {
    case on
    case off
    case unavailable(String)

    var isOn: Bool {
        if case .on = self { return true }
        return false
    }

    var label: String {
        switch self {
        case .on:
            return "On"
        case .off:
            return "Off"
        case .unavailable:
            return "Unavailable"
        }
    }
}

enum PowerMode: Equatable {
    case normal
    case batterySaver
    case mixed
    case unknown

    var title: String {
        switch self {
        case .normal:
            return "Normal Mode"
        case .batterySaver:
            return "Battery Saver"
        case .mixed:
            return "Mixed Settings"
        case .unknown:
            return "Status Unknown"
        }
    }

    var subtitle: String {
        switch self {
        case .normal:
            return "Background wake and keepalive are enabled."
        case .batterySaver:
            return "Background wake and keepalive are quiet."
        case .mixed:
            return "Your Mac settings are not aligned yet."
        case .unknown:
            return "PowerNap Toggler could not read every setting."
        }
    }

    var symbolName: String {
        switch self {
        case .normal:
            return "sun.max.fill"
        case .batterySaver:
            return "moon.fill"
        case .mixed:
            return "circle.lefthalf.filled"
        case .unknown:
            return "questionmark.circle"
        }
    }

    var nextMode: PowerMode {
        self == .batterySaver ? .normal : .batterySaver
    }
}

struct PowerSnapshot: Equatable {
    var powerNap: PowerSettingState
    var tcpKeepalive: PowerSettingState

    var mode: PowerMode {
        switch (powerNap, tcpKeepalive) {
        case (.on, .on):
            return .normal
        case (.off, .off):
            return .batterySaver
        case (.unavailable, _), (_, .unavailable):
            return .unknown
        default:
            return .mixed
        }
    }
}

struct CommandResult {
    let succeeded: Bool
    let output: String
}

enum LaunchAccessState: Equatable {
    case freeLaunch(daysRemaining: Int)
    case licensed
    case expired

    var canApplyChanges: Bool {
        switch self {
        case .freeLaunch, .licensed:
            return true
        case .expired:
            return false
        }
    }

    var title: String {
        switch self {
        case .freeLaunch(let daysRemaining):
            return daysRemaining <= 1 ? "Free launch ends today" : "Free launch: \(daysRemaining) days left"
        case .licensed:
            return "Licensed"
        case .expired:
            return "Free launch ended"
        }
    }

    var subtitle: String {
        switch self {
        case .freeLaunch:
            return "After the launch window, PowerNap Toggler requires the one-time license."
        case .licensed:
            return "Thanks for supporting the app."
        case .expired:
            return "Unlock the one-time license to keep switching modes."
        }
    }
}

enum LaunchAccess {
    static let purchaseURL = URL(string: "https://powernaptoggler.framer.ai/#pricing")!

    private static let licenseFlagKey = "hasPowerNapTogglerLicense"

    private static var freeLaunchEndDate: Date {
        var components = DateComponents()
        components.calendar = Calendar(identifier: .gregorian)
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.year = 2026
        components.month = 6
        components.day = 9
        return components.date ?? Date.distantPast
    }

    static func currentState(now: Date = Date()) -> LaunchAccessState {
        if UserDefaults.standard.bool(forKey: licenseFlagKey) {
            return .licensed
        }

        guard now < freeLaunchEndDate else {
            return .expired
        }

        let secondsRemaining = freeLaunchEndDate.timeIntervalSince(now)
        let daysRemaining = max(1, Int(ceil(secondsRemaining / 86_400)))
        return .freeLaunch(daysRemaining: daysRemaining)
    }
}

@main
struct PowerNapTogglerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private let manager = NapManager.shared
    private let popover = NSPopover()
    private var statusItem: NSStatusItem?
    private var monitor: Any?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        configureStatusItem()
        configurePopover()
        manager.refresh()
        updateStatusIcon()
    }

    func applicationWillTerminate(_ notification: Notification) {
        if let monitor {
            NSEvent.removeMonitor(monitor)
        }
    }

    private func configureStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        guard let button = statusItem?.button else { return }

        button.target = self
        button.action = #selector(statusItemClicked(_:))
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        button.toolTip = "PowerNap Toggler"
        updateStatusIcon()
    }

    private func configurePopover() {
        popover.behavior = .transient
        popover.contentSize = NSSize(width: 360, height: 480)
        popover.contentViewController = NSHostingController(
            rootView: PowerNapPanel(
                manager: manager,
                close: { [weak self] in self?.popover.performClose(nil) }
            )
        )

        monitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] _ in
            Task { @MainActor in
                self?.popover.performClose(nil)
            }
        }
    }

    @objc private func statusItemClicked(_ sender: NSStatusBarButton) {
        guard let event = NSApp.currentEvent else {
            togglePopover(sender)
            return
        }

        if event.type == .rightMouseUp {
            showContextMenu()
        } else {
            togglePopover(sender)
        }
    }

    private func togglePopover(_ sender: NSStatusBarButton) {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            manager.refresh()
            updateStatusIcon()
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .minY)
        }
    }

    private func showContextMenu() {
        let menu = NSMenu()
        menu.addItem(withTitle: manager.snapshot.mode.title, action: nil, keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Open PowerNap Toggler", action: #selector(openPanelFromMenu), keyEquivalent: "")
        menu.addItem(withTitle: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        statusItem?.menu = menu
        statusItem?.button?.performClick(nil)
        statusItem?.menu = nil
    }

    @objc private func openPanelFromMenu() {
        guard let button = statusItem?.button else { return }
        togglePopover(button)
    }

    @objc private func quitApp() {
        NSApp.terminate(nil)
    }

    private func updateStatusIcon() {
        guard let button = statusItem?.button else { return }
        let mode = manager.snapshot.mode
        let image = NSImage(
            systemSymbolName: mode.symbolName,
            accessibilityDescription: mode.title
        )
        image?.isTemplate = true
        button.image = image
        button.imagePosition = .imageOnly
        button.toolTip = "PowerNap Toggler - \(mode.title)"
    }
}

@MainActor
final class NapManager: ObservableObject {
    static let shared = NapManager()

    @Published private(set) var snapshot = PowerSnapshot(powerNap: .unavailable("Not checked yet"), tcpKeepalive: .unavailable("Not checked yet"))
    @Published private(set) var isApplying = false
    @Published private(set) var lastMessage = "Ready"
    @Published private(set) var didExplainPrivileges = UserDefaults.standard.bool(forKey: "didExplainPrivileges")
    @Published private(set) var accessState = LaunchAccess.currentState()

    private init() {}

    var targetMode: PowerMode {
        snapshot.mode.nextMode
    }

    func markPrivilegesExplained() {
        didExplainPrivileges = true
        UserDefaults.standard.set(true, forKey: "didExplainPrivileges")
    }

    func refresh() {
        accessState = LaunchAccess.currentState()
        snapshot = PowerSnapshot(
            powerNap: readPowerNapState(),
            tcpKeepalive: readTCPKeepaliveState()
        )
    }

    @MainActor
    func apply(_ mode: PowerMode) async {
        guard mode == .normal || mode == .batterySaver else { return }
        accessState = LaunchAccess.currentState()
        guard accessState.canApplyChanges else {
            lastMessage = "Free launch access ended. Unlock to continue."
            openPurchasePage()
            return
        }

        isApplying = true
        lastMessage = "Applying \(mode.title)..."

        let enabledValue = mode == .normal ? "1" : "0"
        let command = """
        /usr/bin/pmset -a powernap \(enabledValue) && /usr/sbin/sysctl -w net.inet.tcp.always_keepalive=\(enabledValue)
        """

        let result = await runPrivileged(command)
        refresh()

        if result.succeeded, snapshot.mode == mode {
            lastMessage = "\(mode.title) is on"
        } else if result.succeeded {
            lastMessage = "Settings changed, but the Mac reports \(snapshot.mode.title)"
        } else {
            lastMessage = cleanedFailureMessage(from: result.output)
        }

        isApplying = false
    }

    func openPurchasePage() {
        NSWorkspace.shared.open(LaunchAccess.purchaseURL)
    }

    private func readPowerNapState() -> PowerSettingState {
        let output = shellOutput("/usr/bin/pmset -g custom 2>/dev/null | /usr/bin/grep -E 'powernap[[:space:]]+[01]' | /usr/bin/tail -1")
        guard !output.isEmpty else {
            return .unavailable("Power Nap was not reported by pmset.")
        }
        return output.contains("1") ? .on : .off
    }

    private func readTCPKeepaliveState() -> PowerSettingState {
        let output = shellOutput("/usr/sbin/sysctl net.inet.tcp.always_keepalive 2>/dev/null")
        guard !output.isEmpty else {
            return .unavailable("TCP keepalive was not reported by sysctl.")
        }
        return output.contains("1") ? .on : .off
    }

    private func runPrivileged(_ command: String) async -> CommandResult {
        await Task.detached(priority: .userInitiated) {
            let escapedCommand = command
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")

            let script = """
            do shell script "\(escapedCommand)" with administrator privileges with prompt "PowerNap Toggler needs permission to change macOS energy settings."
            """

            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
            task.arguments = ["-e", script]

            let pipe = Pipe()
            task.standardOutput = pipe
            task.standardError = pipe

            do {
                try task.run()
                task.waitUntilExit()
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                let output = String(data: data, encoding: .utf8) ?? ""
                return CommandResult(succeeded: task.terminationStatus == 0, output: output)
            } catch {
                return CommandResult(succeeded: false, output: error.localizedDescription)
            }
        }.value
    }

    private func shellOutput(_ command: String) -> String {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.arguments = ["-lc", command]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe

        do {
            try task.run()
            task.waitUntilExit()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return (String(data: data, encoding: .utf8) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return ""
        }
    }

    private func cleanedFailureMessage(from output: String) -> String {
        if output.localizedCaseInsensitiveContains("User canceled") || output.contains("-128") {
            return "Permission was cancelled. Nothing changed."
        }
        let cleaned = output.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleaned.isEmpty ? "Could not apply settings." : cleaned
    }
}

struct PowerNapPanel: View {
    @ObservedObject var manager: NapManager
    let close: () -> Void

    var body: some View {
        ZStack {
            VisualEffectBackground()
            LinearGradient(
                colors: [
                    Color.white.opacity(0.16),
                    Color.cyan.opacity(0.05),
                    Color.black.opacity(0.18)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 18) {
                    header
                    accessBanner
                    modeCard
                    settingRows
                    footer
                }
                .padding(18)
            }
        }
        .frame(width: 360, height: 480)
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack(spacing: 12) {
            Image(systemName: manager.snapshot.mode.symbolName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 34, height: 34)
                .background(.white.opacity(0.12), in: Circle())
                .overlay(Circle().stroke(.white.opacity(0.18), lineWidth: 1))

            VStack(alignment: .leading, spacing: 2) {
                Text("PowerNap Toggler")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                Text("Menu bar battery control")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.56))
            }

            Spacer()

            Button(action: close) {
                Image(systemName: "xmark")
                    .font(.system(size: 11, weight: .bold))
            }
            .buttonStyle(.plain)
            .foregroundStyle(.white.opacity(0.68))
            .frame(width: 28, height: 28)
            .background(.white.opacity(0.08), in: Circle())
            .help("Close")
        }
    }

    private var modeCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(manager.snapshot.mode.title)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                Text(manager.snapshot.mode.subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.66))
            }

            if !manager.didExplainPrivileges {
                permissionNote
            }

            Button {
                if manager.accessState.canApplyChanges {
                    if !manager.didExplainPrivileges {
                        manager.markPrivilegesExplained()
                    }
                    Task { await manager.apply(manager.targetMode) }
                } else {
                    manager.openPurchasePage()
                }
            } label: {
                HStack {
                    if manager.isApplying {
                        ProgressView()
                            .controlSize(.small)
                            .tint(.black)
                    } else {
                        Image(systemName: manager.accessState.canApplyChanges ? manager.targetMode.symbolName : "lock.open")
                    }
                    Text(primaryButtonTitle)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 42)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.black)
            .background(
                LinearGradient(
                    colors: [Color.white, Color(red: 0.72, green: 0.91, blue: 1.0)],
                    startPoint: .top,
                    endPoint: .bottom
                ),
                in: RoundedRectangle(cornerRadius: 10, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(.white.opacity(0.55), lineWidth: 1)
            )
            .disabled(manager.isApplying)

            Text(manager.lastMessage)
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.58))
                .lineLimit(2)
        }
        .padding(16)
        .background(.black.opacity(0.28), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.white.opacity(0.14), lineWidth: 1)
        )
    }

    private var accessBanner: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: manager.accessState.canApplyChanges ? "checkmark.seal.fill" : "lock.fill")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(manager.accessState.canApplyChanges ? Color(red: 0.7, green: 0.92, blue: 1.0) : Color(red: 1.0, green: 0.78, blue: 0.42))

            VStack(alignment: .leading, spacing: 3) {
                Text(manager.accessState.title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.86))
                Text(manager.accessState.subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.56))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .background(.white.opacity(0.065), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(.white.opacity(0.09), lineWidth: 1)
        )
    }

    private var primaryButtonTitle: String {
        if manager.isApplying {
            return "Applying..."
        }

        if manager.accessState.canApplyChanges {
            return "Switch to \(manager.targetMode.title)"
        }

        return "Unlock to continue"
    }

    private var permissionNote: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "lock.shield")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color(red: 0.74, green: 0.9, blue: 1.0))
            Text("macOS will ask for your password before changing built-in energy settings.")
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.68))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private var settingRows: some View {
        VStack(spacing: 8) {
            SettingRow(title: "Power Nap", detail: "Background wake during sleep", state: manager.snapshot.powerNap)
            SettingRow(title: "TCP Keepalive", detail: "Network keepalive while idle", state: manager.snapshot.tcpKeepalive)
        }
    }

    private var footer: some View {
        HStack {
            Button {
                manager.refresh()
            } label: {
                Label("Refresh", systemImage: "arrow.clockwise")
            }
            .buttonStyle(SecondaryButtonStyle())

            Spacer()

            Text("Runs on-device")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.white.opacity(0.46))
        }
    }
}

struct SettingRow: View {
    let title: String
    let detail: String
    let state: PowerSettingState

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 8, height: 8)
                .shadow(color: indicatorColor.opacity(0.6), radius: 6)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.9))
                Text(detail)
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.48))
            }

            Spacer()

            Text(state.label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.white.opacity(0.75))
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(.white.opacity(0.08), in: Capsule())
        }
        .padding(12)
        .background(.white.opacity(0.055), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1)
        )
    }

    private var indicatorColor: Color {
        switch state {
        case .on:
            return Color(red: 0.4, green: 0.86, blue: 1.0)
        case .off:
            return Color(red: 0.62, green: 0.62, blue: 0.68)
        case .unavailable:
            return Color(red: 1.0, green: 0.62, blue: 0.38)
        }
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.white.opacity(configuration.isPressed ? 0.62 : 0.76))
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(.white.opacity(configuration.isPressed ? 0.04 : 0.08), in: Capsule())
    }
}

struct VisualEffectBackground: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = .hudWindow
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
