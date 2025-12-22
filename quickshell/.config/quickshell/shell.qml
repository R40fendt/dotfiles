import Quickshell
import QtQuick
import Quickshell.Widgets
import Quickshell.Io

PanelWindow {
		id: root
		aboveWindows: false
		margins.top: 0
		color: "transparent"

		width: Screen.width
		height: Screen.height

		// CPU tracking
    property var lastCpuIdle: 0
		property var lastCpuTotal: 0
		property int cpuUsage: 0
    property int memUsage: 0
    property int diskUsage: 0
		property string todo: "Todo-Liste laden..."
		property string kalender: "Kalender laden..."


		Rectangle {
				color: "#2000ff00"
				radius: 5
				width: 10
				height: 10
				x: 500 
				y: 100 
				

				Text {
					id: titleText
					text: "  CPU: " + cpuUsage +" %"
					font.pixelSize: 24
					anchors.centerIn: parent
					color: "white"
				}
		
		}

		Rectangle {
				color: "#60666666"
				radius: 20 
				width: 600
				height: 600
				x: 50 
				y: 200 
				

				Text {
					id: todoText
					text: todo
					font.pixelSize: 24
					anchors.centerIn: parent
					color: "white"
				}
		
		}
		Rectangle {
				color: "#60666666"
				radius: 20
				width: 600
				height: 600
				x: 700 
				y: 200 
				

				Text {
					id: kalenderText
					text: kalender 
					font.pixelSize: 24
					anchors.centerIn: parent
					color: "white"
				}
		
		}



		Rectangle {
				color: "#2000ff00"

				x: 200
				y: 100
				width: 10
				height: 10


				Text {
					id: titleText2
					text: "Moin!"
					font.pixelSize: 24
					anchors.centerIn: parent
					color: "white"
				}
		
		}
		// CPU usage
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var user = parseInt(parts[1]) || 0
                var nice = parseInt(parts[2]) || 0
                var system = parseInt(parts[3]) || 0
                var idle = parseInt(parts[4]) || 0
                var iowait = parseInt(parts[5]) || 0
                var irq = parseInt(parts[6]) || 0
                var softirq = parseInt(parts[7]) || 0

                var total = user + nice + system + idle + iowait + irq + softirq
                var idleTime = idle + iowait

                if (lastCpuTotal > 0) {
                    var totalDiff = total - lastCpuTotal
                    var idleDiff = idleTime - lastCpuIdle
                    if (totalDiff > 0) {
                        cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff)
                    }
                }
                lastCpuTotal = total
                lastCpuIdle = idleTime
            }
        }
        Component.onCompleted: running = true
    }
		// Process für To-Do List
    Process {
        id: todoProc 
        command: ["calcurse", "-t"]
				stdout: SplitParser {
						splitMarker: "" 
						onRead: data => {
								todo=data
						}
				}
				Component.onCompleted: running=false
    }
		// Process für Kalender 
    Process {
        id: calProc 
        command: ["calcurse", "-d", "3"]
				stdout: SplitParser {
						splitMarker: "" 
						onRead: data => {
								kalender=data
						}
				}
				Component.onCompleted: running=false
    }


		Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            todoProc.running = true
						calProc.running = true
        }
    }

 }
